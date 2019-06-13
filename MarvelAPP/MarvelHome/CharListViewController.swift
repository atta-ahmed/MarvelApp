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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupCollectionView()
         setupTableView()
        presenter.delegate = self
        presenter.fetchCharacters(limit: 10, count: 10, offset: 0)
    }
 
    func setupTableView(){ 
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
   
        
        tableView.frame = CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height - barHeight)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MarvelMainTableViewCell", bundle: nil), forCellReuseIdentifier: "MarvelMainTableViewCell")
    }
    
    func setupCollectionView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        collectionLayout.itemSize = CGSize(width: width   , height: 160)
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = collectionLayout

        collectionView.frame = CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height - barHeight)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CharListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharListCollectionViewCell")
    }
    
    func onSuccessFetchCharacters(charResponce: CharResponce?) {
        self.charResponce = charResponce
        configTableView()
    }
    
    func configTableView(){
        for char in (charResponce?.charList)! {
            self.charList.append(char)
        }
        tableView.reloadData()
    }
    func configCollectionView(){
        for char in (charResponce?.charList)! {
            self.charList.append(char)
        }
        collectionView.reloadData()
    }
    
}

extension CharListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelMainTableViewCell" , for: indexPath) as? CharListTableViewCell {
            
            cell.configCell(character: charList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}

extension CharListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharListCollectionViewCell" , for: indexPath) as? CharListCollectionViewCell {
            
            cell.configCell(character: charList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

    
}
