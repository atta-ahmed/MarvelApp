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
    let searchController = UISearchController(searchResultsController: nil)
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
        presenter.charLisDelegate = self
        searchController.searchBar.delegate = self
        presenter.fetchCharacters(limit: 20, count: 10, offset: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.backgroundColor = .black
        resetNavigationTransparency()
    }
    
    // MARK:- config UI
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MarvelMainTableViewCell", bundle: nil), forCellReuseIdentifier: "MarvelMainTableViewCell")
        tableView.register(UINib(nibName: "CharSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "CharSearchTableViewCell")
    }
    fileprivate func configTableView(){
        for char in (charResponce?.charList)! {
            self.charList.append(char as! Character)
        }
        tableView.reloadData()
    }
    fileprivate func setNavBarImage(){
        let logo = UIImage(named: "icn-nav-marvel")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    fileprivate func setNavBarButtons(){
        rightBarButton = UIBarButtonItem(image: UIImage(named: "icn-nav-search" ) , style: .done, target: self, action: #selector(ActiveSearch))
        self.navigationItem.rightBarButtonItem = rightBarButton
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
    fileprivate func loadMoreCharacters(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 20.0 {
            DispatchQueue.main.async {
                self.presenter.fetchCharacters(limit: 20, count: 0, offset: self.charList.count)
            }
            spinner.startAnimating()
        }
    }
    fileprivate func showSpinner(){
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    // MARK:- Actions
    fileprivate func navigateToCharacterDetailsView(_ indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            if searchActive {
                vc.setCharacterObj(character: filterdCharList[indexPath.row])
            } else {
                vc.setCharacterObj(character: charList[indexPath.row])
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

// MARK:- table view
extension CharListViewController : UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filterdCharList.count : charList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return searchActive ? 80 : 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchActive {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CharSearchTableViewCell" , for: indexPath) as? CharSearchTableViewCell {
                cell.configCell(character: filterdCharList[indexPath.row])
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToCharacterDetailsView(indexPath)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if searchActive { return }
        loadMoreCharacters(scrollView)
    }
    
}


// MARK:- Search bar
extension CharListViewController: UISearchControllerDelegate , UISearchBarDelegate, UISearchResultsUpdating {
    
    func configureSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        navigationItem.rightBarButtonItems = nil
        navigationItem.titleView = nil
        
        // navigationItem.titleView = searchController.searchBar
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        
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
        self.filterdCharList = self.charList.filter({ $0.name?.hasPrefix(searchText) ?? false })
        
        tableView.reloadData()
    }
    
}
