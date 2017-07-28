//
//  firstPageViewController.swift
//  traffismart
//
//  Created by Tarun kaushik on 09/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class firstPageViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tvBackView: UIView!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var healthButton: UIBarButtonItem!
    
    let first:Card = {
     var card = Card("idle Fuel Wasted" , "32 Liters" , "18.9 km/h")
        card.backGroundColor = UIColor.init(colorLiteralRed: 185/255, green: 45/255, blue: 53/255, alpha: 1)
        return card
    }()
    
    let second:Card = {
        var card = Card("Maintance" , "17 Aug 2016" , "")
     
         card.backGroundColor = UIColor.init(colorLiteralRed: 19/255, green: 143/255, blue:83/255, alpha: 1)
        return card
    }()
    
    let third:Card = {
        var card = Card("Device info" , "IOTD1741" , "connected")
        
         card.backGroundColor = UIColor.init(colorLiteralRed: 253/255, green: 144/255, blue: 37/255, alpha: 1)
        return card
    }()
    
    let fourth: Card = {
        var card = Card("VEHICLE REGISTRATED" , "DL#C####" , "Locate")
                 card.backGroundColor = UIColor.init(colorLiteralRed: 88/255, green: 180/255, blue: 252/255, alpha: 1)
        return card
    }()
    
   var Cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvBackView.layer.cornerRadius = 10
        tvBackView.clipsToBounds = true
    Cards = [self.first,self.second,self.third,self.fourth]
        slideMenu()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! newTableViewCell
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.backgroundColor = Cards[indexPath.section].backGroundColor
        cell.mainInfoLabel.text = Cards[indexPath.section].mainLabel
        cell.mainInfoLabel.textColor = UIColor.white
        cell.titleLabel.text = Cards[indexPath.section].mainInfoLabel
        cell.titleLabel.textColor = UIColor.white
        cell.extraInfoLabel.text = Cards[indexPath.section].extraInfo
        cell.extraInfoLabel.textColor = UIColor.white
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Cards.count
    }
    

    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func slideMenu(){
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            healthButton.target = revealViewController()
            healthButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
