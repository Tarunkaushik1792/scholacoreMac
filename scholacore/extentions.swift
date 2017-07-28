//
//  extentions.swift
//  scholacore
//
//  Created by Tarun kaushik on 29/05/17.
//  Copyright © 2017 Tarun kaushik. All rights reserved.
//


import Foundation
import UIKit

extension UIAlertController{
    
    convenience init(msg:String! , action: String!){
        self.init(title:"Something Happend" , message : msg , preferredStyle: .alert )
        let action = UIAlertAction(cancel:action)
        self.addAction(action)
    }
    
    convenience init(okaction msg:String!){
        let okAction = UIAlertAction(cancel:"OK")
        self.init(title:"Something Happened" , message: msg , preferredStyle: .alert)
        self.addAction(okAction)
    }
    
    /*convenience init(msg:String! , action:String! , completionHandler: @escaping (UIAlertAction) -> Void ){
     let action = UIAlertAction(title:action , style: .default , handler : completionHandler(<#UIAlertAction#>) )
     self.init(title:nil , message:msg , preferredStyle: .alert)
     }*/
    
    convenience init(withAlertTitle alertTitle:String!, msg:String? ,ActionTitle actionTitle:String! ,handler: ((UIAlertAction)->Void)?){
        let action = UIAlertAction(title:actionTitle , style: .cancel){ (action) in
            handler!(action)
        }
        self.init(title:alertTitle , message:msg ,preferredStyle: .alert)
        self.addAction(action)
    }
}

extension UIAlertAction{
    
    convenience init(cancel title:String){
        self.init(title:title , style: .cancel , handler: nil )
        
    }
    
}

extension UIImageView{
    
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
            
        }
        
    }
}

extension UITextField{
    
    @IBInspectable var cornerRadius:CGFloat{
        
        get {
            return self.layer.cornerRadius
        }
        
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
        
    }
    
}

extension UIActivityIndicatorView{
    
    func hide(){
        self.isHidden = true
    }
    
    func show(){
        self.isHidden = false
    }
    
}

extension UIViewController{
    
    func present(WithAnimation ViewController:UIViewController){
        self.present(ViewController , animated: true , completion: nil)
    }
    
    func present(withoutAnimation ViewController : UIViewController){
        self.present(ViewController , animated:false , completion: nil)
    }
    
    func present(withStoryBoardID indetifier : String , animation : Bool){
        let vc = storyboard?.instantiateViewController(withIdentifier: indetifier)
        self.present(vc! , animated: animation , completion : nil )
    }
}


extension Date{
    func dateAt(hours: Int , minutes:Int) -> Date{
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let newDate = calender?.date(bySettingHour: hours, minute: minutes, second: 0, of: Date(), options: [])
        return newDate!
    }
}

extension UIColor{
    
    convenience init(hex : Int){
        
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
       self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
