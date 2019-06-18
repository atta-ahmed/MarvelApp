//
//  DetailsViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    
    @IBOutlet fileprivate weak var bgImage: UIImageView!
    @IBOutlet fileprivate weak var headerImage: UIImageView!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var presenter = DetailsPresenter()
    
    fileprivate var comicsResponce: [Details]?
    fileprivate var storiesResponce: [Details]?
    fileprivate var eventsResponce: [Details]?
    fileprivate var seriesResponce: [Details]?
    fileprivate var character: Character?
    fileprivate var isSelectedBefor = false
    fileprivate var storedOffsets = [Int: CGFloat]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        makeNavigationTransparent()
        setTableContentInset()
        setUpNavBar()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.detailsdelegate = self
        setupTableView()
        adjustTableHeaderHight()
        setUpBackGroundView()
        checkIfCallApiOrNot()
    }
    
    // MARK:- Config UI
    fileprivate func hideBackBtnUntilApiFinished() {
        navigationItem.setHidesBackButton(true, animated:true)
    }
    fileprivate func ShowBackBtnWhenApiFinished() {
        navigationItem.setHidesBackButton(false, animated:true)
    }
    fileprivate func setUpNavBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        // navigationController?.navigationBar.barStyle = .black
    }
    fileprivate func setUpBackGroundView() {
        bgImage.downloadImageByKF(imagePath: character?.thumImage?.fullPath())
        addBlureEffect()
    }
    fileprivate func callDetailsApi(){
        if let charId = character?.id {
            hideBackBtnUntilApiFinished()
            self.showLoadingIndicator(boxView)
            presenter.fetchComics(limit: 20, offset: 0, charId: charId)
            presenter.fetchStories(limit: 20, offset: 0, charId: charId)
            presenter.fetchEvents(limit: 20, offset: 0, charId: charId)
            presenter.fetchSeries(limit: 20, offset: 0, charId: charId)
            presenter.setupdispatchGroup()
        }
    }
    fileprivate func setTableContentInset(){
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsets( top: -y , left: 0, bottom: 20, right: 0)
        }
    }
    fileprivate func adjustTableHeaderHight() {
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: view.frame.height * 0.5)
    }
    
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        headerImage.downloadImageByKF(imagePath: character?.thumImage?.fullPath())
    }
    fileprivate func addBlureEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bgImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgImage.addSubview(blurEffectView)
    }
    fileprivate func checkIfCallApiOrNot() {
        if isSelectedBefor {
            tableView.reloadData()
        } else {
            character?.charDetails.removeAll()
            callDetailsApi()
        }
    }
    
    // MARK:- Setters
    func setCharacterObj(character: Character?, isSelected: Bool){
        self.character = character
        self.isSelectedBefor = isSelected
    }
    
    fileprivate func isSelectedCharEqualPreviousChar(charId: Int , previousId: Int) -> Bool {
        return charId == previousId
    }
    
    
}

extension DetailsViewController: DetailsPresenterDelegate {
    
    func onSuccessFetchComics(comicsResponce: [Details]?) {
        self.comicsResponce = comicsResponce
        if comicsResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Comics": comicsResponce!])
        }
    }
    
    func onSuccessFetchStories(storiesResponce: [Details]?) {
        self.storiesResponce = storiesResponce
        if storiesResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Stories": storiesResponce!])
        }
    }
    
    func onSuccessFetchEvents(eventsResponce: [Details]?) {
        self.eventsResponce = eventsResponce
        if eventsResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Events": eventsResponce!])
        }
    }
    
    func onSuccessFetchSeries(seriesResponce: [Details]?) {
        self.seriesResponce = seriesResponce
        if seriesResponce?.count ?? 0 > 0 {
            self.character?.charDetails.append(["Series": seriesResponce!])
        }
    }
    
    func onSuccessFetchAll(characterDetail: Character?) {
        navigationItem.hidesBackButton = false
        tableView.reloadData()
        hideLoadingIndicator(boxView)
    }
    
    func onError() {
        ShowBackBtnWhenApiFinished()
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
                        cell.isHidden = true // TODO
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
        return section == 0 ? 0 : 30
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 , indexPath.row > 1{
            return 240
        }
        return tableView.estimatedRowHeight
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let path = character?.links[indexPath.row].url , let url = URL(string: path) {
                UIApplication.shared.open( url, options: [:], completionHandler: nil)
            }
        }
    }
    
}

extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = (character?.charDetails[collectionView.tag - 2].keys.first) ?? "" // TODO
        return (character?.charDetails[collectionView.tag - 2][key]?.count) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        
        let ArrayObj = character?.charDetails[collectionView.tag - 2].values.first
        let obj = ArrayObj![indexPath.row]
        cell.configCollectionDetail(obj: obj)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageSliderViewController") as? ImageSliderViewController {
            if  let ArrayObj = character?.charDetails[collectionView.tag - 2].values.first {
                vc.imageSourceArray = ArrayObj
            }
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 3.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
