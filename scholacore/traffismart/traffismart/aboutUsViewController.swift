//
//  aboutUsViewController.swift
//  traffismart
//
//  Created by Tarun kaushik on 08/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class aboutUsViewController: UIViewController {
   
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var backView: UIView!
    @IBOutlet var tarunImage: UIImageView!
    @IBOutlet var monkeyImage: UIImageView!
    @IBOutlet var rashikaImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
     slideMenu()
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        tarunImage.layer.cornerRadius = 30
        tarunImage.clipsToBounds = true
        monkeyImage.layer.cornerRadius = 30
        monkeyImage.clipsToBounds = true
        rashikaImage.layer.cornerRadius = 30
        rashikaImage.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func slideMenu(){
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
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
