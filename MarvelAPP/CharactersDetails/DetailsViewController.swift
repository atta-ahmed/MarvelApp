//
//  DetailsViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController, DetailsPresenterDelegate {
    
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter = DetailsPresenter()
    
    var comicsResponce: [Details]?
    var storiesResponce: [Details]?
    var eventsResponce: [Details]?
    var seriesResponce: [Details]?
    
    var character: Character?
    
    var storedOffsets = [Int: CGFloat]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeNavigationTransparent()
        setTableContentInset()
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        callDetailsApi()
        setupTableView()
        bgImage.downloadImageByKF(imagePath: character?.thumImage?.fullPath())
        addBlureEffect()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        character?.charDetails.removeAll()
    }
    
    func callDetailsApi(){
        if let charId = character?.id {
            self.showLoadingIndicator(boxView)
            presenter.fetchComics(limit: 20, offset: 0, charId: charId)
            presenter.fetchStories(limit: 20, offset: 0, charId: charId)
            presenter.fetchEvents(limit: 20, offset: 0, charId: charId)
            presenter.fetchSeries(limit: 20, offset: 0, charId: charId)
            presenter.setupdispatchGroup()
        }
    }
    
    func setTableContentInset(){
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsets( top: -y , left: 0, bottom: 20, right: 0)
        }
        
    }
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        headerImage.downloadImageByKF(imagePath: character?.thumImage?.fullPath())
    }
    
    func addBlureEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bgImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgImage.addSubview(blurEffectView)
    }
    
    
    func onSuccessFetchComics(comicsResponce: [Details]?) {
        self.comicsResponce = comicsResponce
        if comicsResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Comics": comicsResponce!])
        }
        print("fetch comics")
        
    }
    
    func onSuccessFetchStories(storiesResponce: [Details]?) {
        self.storiesResponce = storiesResponce
        if storiesResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Stories": storiesResponce!])
        }
        print("fetch Stories")
        
    }
    
    func onSuccessFetchEvents(eventsResponce: [Details]?) {
        self.eventsResponce = eventsResponce
        if eventsResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Events": eventsResponce!])
        }
        print("fetch events")
        
    }
    
    func onSuccessFetchSeries(seriesResponce: [Details]?) {
        self.seriesResponce = seriesResponce
        if seriesResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Series": seriesResponce!])
        }
        print("fetch series")
    }
    
    func onSuccessFetchAll(characterDetail: Character?) {
        
        tableView.reloadData()
        hideLoadingIndicator(boxView)
        
    }
    
    
}

extension DetailsViewController : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (character?.charDetails.count ?? 0) + 2
        }
        return character?.links.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame
        let title = UILabel()
        title.frame = CGRect(x: 5, y: 10, width: headerFrame.size.width, height: 20)
        title.text = "RELATED LINKS"
        title.font = UIFont.systemFont(ofSize: 12)
        title.textColor = UIColor.red
        let headerView:UIView =  UIView(frame: CGRect(x: 5, y: 0, width: headerFrame.size.width , height: headerFrame.size.height + 20) )
        headerView.backgroundColor = UIColor.clear
        headerView.addSubview(title)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "infoTableViewCell") as? infoTableViewCell {
                    
                    cell.titleLable.text = "NAME"
                    cell.detailsLable.text = character?.name ?? "Not found"
                    return cell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "infoTableViewCell") as? infoTableViewCell {
                    if character?.description == "" {
                        cell.isHidden = true
                        return cell
                    }
                    cell.titleLable.text = "DESCRIPTION"
                    cell.detailsLable.text = character?.description
                    return cell
                }
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
                cell.titleLable.text = character?.charDetails[indexPath.row - 2].keys.first
                return cell

            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LinksTableViewCell") as? LinksTableViewCell {
                if (character?.links[indexPath.row]) != nil {
                    cell.linkLable?.text = character?.links[indexPath.row].type
                }
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row  > 1 {
                return 220
            }
            return tableView.estimatedRowHeight
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? DetailsTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? DetailsTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    
}

extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = (character?.charDetails[collectionView.tag - 2].keys.first) ?? ""
        return (character?.charDetails[collectionView.tag - 2][key]?.count) ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        
        let ArrayObj = character?.charDetails[collectionView.tag - 2].values.first
        let obj = ArrayObj![indexPath.row]
        
        let imagPath = obj.thumImage?.fullPath()
        cell.image.downloadImageByKF(imagePath: imagPath)
        cell.Namelabel.text = obj.title ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
