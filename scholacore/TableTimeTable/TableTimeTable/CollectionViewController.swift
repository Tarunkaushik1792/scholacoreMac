//
//  CollectionViewController.swift
//  TableTimeTable
//
//  Created by Tarun kaushik on 05/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    let items = ["POM","FM","MM","STAT","lang","EM","ME"]
    let days = ["","Mon","Tue","Wed","Thrus","Fri","Sat"]
    var i = 1
    let colors = [
        UIColor(red: 233/255, green: 203/255, blue: 198/255, alpha: 1),
        UIColor(red: 38/255, green: 188/255, blue: 192/255, alpha: 1),
        UIColor(red: 253/255, green: 221/255, blue: 164/255, alpha: 1),
        UIColor(red: 235/255, green: 154/255, blue: 171/255, alpha: 1),
        UIColor(red: 87/255, green: 141/255, blue: 155/255, alpha: 1),
        UIColor(red: 92/255, green: 154/255, blue: 100/255, alpha: 1),
        UIColor(red: 192/255, green: 141/255, blue: 155/255, alpha: 1)
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell
        // Configure the cell
        if indexPath.section == 0{
        cell?.label.text = days[indexPath.row]
        cell?.label.textColor = UIColor.darkText
        cell?.backgroundColor = UIColor.clear
        
        }else if indexPath.row == 0 && indexPath.section != 3 && indexPath.section != 6 {
        cell?.label.text = "\(i)"
         i += 1
        }else if indexPath.section == 3 || indexPath.section == 6{
         cell?.label.text = "Break"
         cell?.backgroundColor = UIColor.white
         cell?.label.textColor = UIColor.black
        }else{
        cell?.label.text = items[Int(arc4random_uniform(7))]
            cell?.backgroundColor = colors[Int(arc4random_uniform(7))]
        }
        return cell!
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
