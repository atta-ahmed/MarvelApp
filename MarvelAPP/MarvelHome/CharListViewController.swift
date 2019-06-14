//
//  CharListViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class CharListViewController: UIViewController, CharListPresenterDelegate {
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    var presenter = CharListPresenter()
    var charResponce : CharResponce?
    var charList: [Character] = []
    var filterdCharList: [Character] = []
    
    var searchActive : Bool = false
   // lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect.zero)
    let searchController = UISearchController(searchResultsController: nil)
    var rightBarButton = UIBarButtonItem()

    lazy var  spinner : UIActivityIndicatorView = {
        let spinner =  UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        spinner.color = UIColor.red
        return spinner
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        rightBarButton = UIBarButtonItem(image: UIImage(named: "add-1" ) , style: .done, target: self, action: #selector(ActiveSearch))
        self.navigationItem.rightBarButtonItem = rightBarButton
        presenter.delegate = self
        presenter.fetchCharacters(limit: 20, count: 10, offset: 0)
    }
 
  @objc func ActiveSearch(){
        searchActive = true
        configureSearchController()
    }
    
    func setupTableView(){ 

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MarvelMainTableViewCell", bundle: nil), forCellReuseIdentifier: "MarvelMainTableViewCell")
        tableView.register(UINib(nibName: "CharSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "CharSearchTableViewCell")
    }
    
    func onSuccessFetchCharacters(charResponce: CharResponce?) {
        self.charResponce = charResponce
        spinner.stopAnimating()
        configTableView()
    }
    
    func configTableView(){
        for char in (charResponce?.charList)! {
            self.charList.append(char)
        }
        tableView.reloadData()
    }
    
}

extension CharListViewController : UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filterdCharList.count
        } else {
            return charList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchActive {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CharSearchTableViewCell" , for: indexPath) as? CharSearchTableViewCell {
                
                cell.configCell(character: charList[indexPath.row])
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelMainTableViewCell" , for: indexPath) as? CharListTableViewCell {
                
                cell.configCell(character: charList[indexPath.row])
                return cell
            }
        }
      
        return UITableViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if searchActive {
            return
        }
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 20.0 {
            DispatchQueue.main.async {
                self.presenter.fetchCharacters(limit: 20, count: 0, offset: self.charList.count)
            }
            spinner.startAnimating()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchActive {
            return 80
        }
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        if searchActive {
            vc.character = filterdCharList[indexPath.row]
        } else {
            vc.character = charList[indexPath.row]
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension CharListViewController: UISearchControllerDelegate , UISearchBarDelegate, UISearchResultsUpdating {
 
    
    func configureSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.rightBarButtonItems = nil

        navigationItem.titleView = searchController.searchBar
        searchController.searchBar.placeholder = "Search ..."

        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //applySearch(searchText: searchController.searchBar.text!)
        let searchBar = searchController.searchBar
        applySearch(searchText: searchBar.text!)
    }
  
     func applySearch(searchText: String) {
        if searchText != "" {

        self.filterdCharList = self.charList.filter() {
            if ($0.name!.lowercased().hasPrefix(searchText.lowercased())){
                return true
            }else{
                return false
            }
        }
        } else {
            filterdCharList.removeAll()
        }
        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applySearch(searchText: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.searchController?.searchBar.isHidden = true
        filterdCharList.removeAll()
        tableView.reloadData()
    }

    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }

}
