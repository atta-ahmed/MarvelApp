//
//  CharListViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class CharListViewController: UIViewController, CharListPresenterDelegate {
    
    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- vars
    var presenter = CharListPresenter()
    var charResponce : CharResponce?
    var charList: [Character] = []
    var filterdCharList: [Character] = []
    var searchActive : Bool = false
    
    // MARK:- UI vars
    var rightBarButton = UIBarButtonItem()
    lazy var  spinner : UIActivityIndicatorView = {
        let spinner =  UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        spinner.color = UIColor.red
        return spinner
    }()
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setNavBarImage()
        setNavBarButtons()
        presenter.delegate = self
        presenter.fetchCharacters(limit: 20, count: 10, offset: 0)
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    // MARK:- config UI
    func setupTableView(){ 
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MarvelMainTableViewCell", bundle: nil), forCellReuseIdentifier: "MarvelMainTableViewCell")
        tableView.register(UINib(nibName: "CharSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "CharSearchTableViewCell")
    }
    func configTableView(){
        for char in (charResponce?.charList)! {
            self.charList.append(char)
        }
        tableView.reloadData()
    }
    
    // MARK:- Helpers
    func onSuccessFetchCharacters(charResponce: CharResponce?) {
        self.charResponce = charResponce
        spinner.stopAnimating()
        configTableView()
    }
    
    @objc func ActiveSearch(){
        searchActive = true
        configureSearchController()
    }
    func setNavBarImage(){
        let logo = UIImage(named: "icn-nav-marvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    func setNavBarButtons(){
        rightBarButton = UIBarButtonItem(image: UIImage(named: "icn-nav-search" ) , style: .done, target: self, action: #selector(ActiveSearch))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    
}

// MARK:- table view
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
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
        
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


// MARK:- Search bar
extension CharListViewController: UISearchControllerDelegate , UISearchBarDelegate, UISearchResultsUpdating {
    
    func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        navigationItem.rightBarButtonItems = nil
        navigationItem.titleView = nil
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search ..."
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        tableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        applySearch(searchText: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applySearch(searchText: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.searchController = nil
        setNavBarImage()
        filterdCharList.removeAll()
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            tableView.reloadData()
        }
    }
    
    func applySearch(searchText: String) {
        
        if searchText == "" {
            filterdCharList.removeAll()
            return 
        }
        self.filterdCharList = self.charList.filter() {
            return ($0.name!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil)
        }
        
        
        tableView.reloadData()
    }
    
    
    
}
