//
//  ViewController.swift
//  UniOrient
//
//  Created by APPLE on 27/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.perform(#selector(self.Call), with: nil, afterDelay: 0.2)
        self.perform(#selector(self.Call), with: nil, afterDelay: 2)
        
    }
    
    @objc func Call(){
        
        if !(Reachability()!.isReachable) {
            print("No Internet from Splash..................")
        }
        else {
            self.GoToHomePage()
        }
    }
    
    func GoToHomePage(){
        
        let navCtrl = self.storyboard?.instantiateViewController(withIdentifier: "NavigationControllerSBID")
        self.present(navCtrl!, animated: true, completion: nil)
        
    }
}

