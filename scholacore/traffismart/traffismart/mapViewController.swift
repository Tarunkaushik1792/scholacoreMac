//
//  mapViewController.swift
//  traffismart
//
//  Created by Tarun kaushik on 09/06/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController {
    @IBOutlet var map: MKMapView!

    @IBOutlet var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenu()
        
        var location = CLLocationCoordinate2D(latitude: 28.5270996,longitude: 77.2317544)
        var span = MKCoordinateSpan(latitudeDelta: 0.002,longitudeDelta: 0.002)
        var region = MKCoordinateRegion(center: location , span: span)
        map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Your Location"
        map.addAnnotation(annotation)
        
        // Do any additional setup after loading the view.
    }


  
    @IBAction func callAction(_ sender: Any) {
        let menu = UIAlertController(title:"Call",message:"",preferredStyle:.actionSheet)
        let action = UIAlertAction(title:"Call 1800-890802" , style:.default , handler: nil)
        let cancel = UIAlertAction(title:"Cancel" , style: .cancel , handler: nil)
        menu.addAction(cancel)
        menu.addAction(action)
        present(menu , animated: true)
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
