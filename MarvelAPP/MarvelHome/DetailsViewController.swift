//
//  DetailsViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var character: Character?
    var storedOffsets = [Int: CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView?.backgroundColor = .red
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")
                cell?.textLabel?.text = "Nmae"
                cell?.detailTextLabel?.text = " System group container for systemgroup.com.apple.configurationprofiles path is systemgroup.com.apple.configurationprofiles"
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")
                cell?.textLabel?.text = "description"
                cell?.detailTextLabel?.text = " System group container for systemgroup.com.apple.configurationprofiles path is systemgroup.com.apple.configurationprofiles"
                return cell!
            case 2,3,4,5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
             //   cell.collectionView.register(UINib.init(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")

//                cell.configCollection()
               // cell.titleLable.text = "Comics"
                return cell
            default:
                break
                
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinksCell")
            cell?.textLabel?.text = " System group container "
            cell?.accessoryType = .disclosureIndicator
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            
            return "links"
        }
        return ""
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
                return 200
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

extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //   self.titleLable.text = "hjhjhjhj"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        
        cell.image.downloadImageByKF(imagePath: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg")
        cell.Namelabel.text = "kkkkkkkkk"
        
        return cell
    }

}
