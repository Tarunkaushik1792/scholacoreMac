//
//  mainViewController.swift
//  traffismart
//
//  Created by Tarun kaushik on 08/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var healthButton: UIBarButtonItem!
    @IBOutlet var carImage: UIImageView!
    @IBOutlet var lowerView: UIView!
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var thirdView: UIView!
    @IBOutlet var fourthView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      slideMenu()
        carImage.layer.cornerRadius = 75
        carImage.clipsToBounds = true
        lowerView.layer.cornerRadius = 10
        lowerView.clipsToBounds = true
        firstView.layer.cornerRadius = 5
        firstView.clipsToBounds = true
        secondView.layer.cornerRadius = 5
        secondView.clipsToBounds = true
        thirdView.layer.cornerRadius = 5
        thirdView.clipsToBounds = true
        fourthView.layer.cornerRadius = 5
        fourthView.clipsToBounds = true
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
