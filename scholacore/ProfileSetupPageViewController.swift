//
//  ProfileSetupPageViewController.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//

import UIKit

class ProfileSetupPageViewController: UIPageViewController ,UIPageViewControllerDataSource {
    
    
    lazy var viewControllersArray: [UIViewController] = {
        let sb = UIStoryboard(name: "Main" , bundle: nil)
        let userDetailVc =  sb.instantiateViewController(withIdentifier: "UserDetailsVC")
        let diplayPicVc = sb.instantiateViewController(withIdentifier: "DisplayPicVC")
        return [userDetailVc , diplayPicVc]
    }()
    
    
    
    var presentVc:UIViewController!
    
    @IBAction func buttonAction(_ sender: Any){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        // Do any additional setup after loading the view.
        if let firstViewController = viewControllersArray.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            presentVc = firstViewController
        }
        self.view.backgroundColor = UIColor.white
        
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersArray.index(of: viewController) else{return nil}
        
        if index == 1{
            return nil
        }
        presentVc = viewController
        //return viewControllersArray[1]
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersArray.index(of: viewController) else{return nil}
        
        if index == 0{
            return nil
        }
        presentVc = viewController
        // return viewControllersArray[0]
        return nil
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllersArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let pvc = presentVc{
            return viewControllersArray.index(of: pvc)!
        }
        return 1
    }
    
    func forward(){
        
        let pvc = viewControllersArray.last
        self.setViewControllers([ pvc!], direction: .forward, animated: true, completion: nil)
        
        
    }
    
    func backWard(){
        let pvc = viewControllersArray.first
        self.setViewControllers([ pvc!], direction: .reverse, animated: true, completion: nil)
        
        
    }
    
}

