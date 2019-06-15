//
//  DetailsViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, DetailsPresenterDelegate {
    
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter = DetailsPresenter()
    
    var comicsResponce: CharResponce?
    var storiesResponce: CharResponce?
    var eventsResponce: CharResponce?
    var seriesResponce: CharResponce?
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
    
    func callDetailsApi(){
        if let charId = character?.id {
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
            self.tableView.contentInset = UIEdgeInsets( top: -y , left: 0, bottom: 0, right: 0)
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
    
    func onSuccessFetchDetails(charResponce: CharResponce?) {
        comicsResponce = charResponce
        let x = comicsResponce?.charList[0].thumImage?.fullPath()
        let y = x
        
    }
    
    func onSuccessFetchComics(comicsResponce: CharResponce?) {
        self.comicsResponce = comicsResponce
        print("fetch comics")
        
    }
    
    func onSuccessFetchStories(storiesResponce: CharResponce?) {
        self.storiesResponce = storiesResponce
        print("fetch Stories")
        
    }
    
    func onSuccessFetchEvents(eventsResponce: CharResponce?) {
        self.eventsResponce = eventsResponce
        print("fetch events")
        
    }
    
    func onSuccessFetchSeries(seriesResponce: CharResponce?) {
        self.seriesResponce = seriesResponce
        print("fetch series")
    }
    
    func onSuccessFetchAll() {
        tableView.reloadData()
        
    }
    
    
}

extension DetailsViewController : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        }
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame
        let title = UILabel()
        title.frame = CGRect(x: 10, y: 10, width: headerFrame.size.width, height: 20)
        title.text = "Links"
        title.textColor = UIColor.red
        let headerView:UIView =  UIView(frame: CGRect(x: 10, y: 0, width: headerFrame.size.width , height: headerFrame.size.height + 20) )
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
                    
                    cell.titleLable.text = "DESCRIPTION"
                    cell.detailsLable.text = character?.description ?? "Not found"
                    return cell
                }
            case 2,3,4,5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
                return cell
            default:
                break
                
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LinksTableViewCell") as? LinksTableViewCell {
                cell.linkLable?.text = "System group container "
                // cell.accessoryType = .disclosureIndicator
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
                return 190
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
        switch collectionView.tag {
        case 2:
            return comicsResponce?.charList.count ?? 0
            
        case 3:
            return seriesResponce?.charList.count ?? 0
            
        case 4:
            return storiesResponce?.charList.count ?? 0
            
        default:
            return eventsResponce?.charList.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        switch collectionView.tag {
        case 2:
            let imagPath = comicsResponce?.charList[indexPath.row].thumImage?.fullPath() ?? ""
            cell.image.downloadImageByKF(imagePath: imagPath)
            cell.Namelabel.text = comicsResponce?.charList[indexPath.row].title ?? "xx"
        case 3:
            
            let imagPath = seriesResponce?.charList[indexPath.row].thumImage?.fullPath() ?? ""
            cell.image.downloadImageByKF(imagePath: imagPath)
            cell.Namelabel.text = seriesResponce?.charList[indexPath.row].title ?? "xx"
        case 4:
            
            let imagPath = storiesResponce?.charList[indexPath.row].thumImage?.fullPath() ?? ""
            cell.image.downloadImageByKF(imagePath: imagPath)
            cell.Namelabel.text = storiesResponce?.charList[indexPath.row].title ?? "xx"
        default:
            
            let imagPath = eventsResponce?.charList[indexPath.row].thumImage?.fullPath() ?? ""
            cell.image.downloadImageByKF(imagePath: imagPath)
            cell.Namelabel.text = eventsResponce?.charList[indexPath.row].title ?? "xx"        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 2
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
