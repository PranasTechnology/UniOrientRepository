//
//  ViewController.swift
//  TakeMyTravel
//
//  Created by apple1 on 02/01/19.
//  Copyright © 2019 pranas. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var loginView: UIView!
    private var revealingLoaded = false
    
    override var shouldAutorotate: Bool {
        return revealingLoaded
        
    }
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var bookingLbl: UILabel!
    @IBOutlet weak var bookingImg: UIImageView!
    @IBOutlet weak var myAccountLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var lblFLight: UILabel!
    @IBOutlet weak var holidayView: UIView!
    @IBOutlet weak var lblHotel: UILabel!
   
    @IBOutlet weak var packageDealCollectView: UICollectionView!
    @IBOutlet weak var flightDealCollectView: UICollectionView!
    var arrFlightDeal : [String] = [String]()
    var arrPackageDeal : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "pageloading.gif")!, iconInitialSize: CGSize(width: self.view.frame.width, height: 150), backgroundImage: UIImage(named: "whiteImg.png")!)//"backgd1.jpeg"
      
        self.view.addSubview(revealingSplashView)
        
        revealingSplashView.duration = 6.0
        
        revealingSplashView.iconColor = UIColor.red
        revealingSplashView.useCustomIconColor = false
        
        revealingSplashView.animationType = SplashAnimationType.swingAndZoomOut
        
        revealingSplashView.startAnimation(){
            self.revealingLoaded = true
            self.setNeedsStatusBarAppearanceUpdate()
            print("Completed")
        }
        
     arrFlightDeal = ["1.jpeg","2.jpeg","3.jpeg","1.jpeg","2.jpeg","3.jpeg"]
     arrPackageDeal = ["3.jpeg","1.jpeg","2.jpeg","3.jpeg","1.jpeg","2.jpeg"]
        
       // Circled VIew
//        flightView.layer.cornerRadius = flightView.frame.size.width/2
//        flightView.clipsToBounds = true
//        flightView.layer.borderColor = UIColor.white.cgColor
//        flightView.layer.borderWidth = 1.0
//
//        hotelView.layer.cornerRadius = hotelView.frame.size.width/2
//        hotelView.clipsToBounds = true
//        hotelView.layer.borderColor = UIColor.white.cgColor
//        hotelView.layer.borderWidth = 1.0
//
        //Gesture View
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        flightView.addGestureRecognizer(tap1)
        flightView.isUserInteractionEnabled = true

        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        hotelView.addGestureRecognizer(tap2)
        hotelView.isUserInteractionEnabled = true
    }

    @objc func handleTap1(_ sender: UITapGestureRecognizer) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "flightSearchVC") as? FlightSearchViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return !UIApplication.shared.isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.fade
    }
    
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "flightSearchVC") as? FlightSearchViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func flightBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "flightSearchVC") as? FlightSearchViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func hotelBtn(_ sender: Any)
    {
    }
    
    @IBAction func loginBtn(_ sender: Any)
    {
        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "LoginPageVC") as! LoginPageVCGoomo
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    @IBAction func holidayBtn(_ sender: Any) {
    }
    @IBAction func homeBtn(_ sender: Any)
    {
        homeImg.image = UIImage (named: "homeViolet")
        homeLbl.textColor = WebServicesUrl.appColor1
        userImg.image = UIImage (named: "userGray")
        myAccountLbl.textColor = UIColor.darkGray
        bookingImg.image = UIImage (named: "briefcaseGray")
        bookingLbl.textColor = UIColor.darkGray
    }
    @IBAction func myaccountBtn(_ sender: Any)
    {
        homeImg.image = UIImage (named: "homeGray")
        homeLbl.textColor = UIColor.darkGray
        userImg.image = UIImage (named: "userViolet")
        myAccountLbl.textColor = WebServicesUrl.appColor1
        bookingImg.image = UIImage (named: "briefcaseGray")
        bookingLbl.textColor = UIColor.darkGray
//        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "LoginPageVC") as! LoginPageVCGoomo
//        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    @IBAction func myBookingBtn(_ sender: Any)
    {
        homeImg.image = UIImage (named: "homeGray")
        homeLbl.textColor = UIColor.darkGray
        userImg.image = UIImage (named: "userGray")
        myAccountLbl.textColor = UIColor.darkGray
        bookingImg.image = UIImage (named: "briefcaseViolet")
        bookingLbl.textColor = WebServicesUrl.appColor1
    }
    
    
////// CollectionView
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == flightDealCollectView
        {
            return arrFlightDeal.count
        }
        else
        {
            return self.arrPackageDeal.count
        }
      
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == flightDealCollectView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
            
            let imgView = cell.viewWithTag(1) as! UIImageView
            imgView.image = UIImage (named: arrFlightDeal[indexPath.row])
            return cell
            
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
            
            let imgView = cell.viewWithTag(1) as! UIImageView
            imgView.image = UIImage (named: arrPackageDeal[indexPath.row])
            return cell
        }
    }
 
}

