//
//  PassengerViewController.swift
//  UniOrient
//
//  Created by Pranas on 23/04/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class PassengerViewController: UIViewController {

    var selectableTraveller : String = String()
    @IBOutlet weak var lblInfant: UILabel!
    @IBOutlet weak var lblChild: UILabel!
    @IBOutlet weak var lblAdult: UILabel!
    
    @IBOutlet weak var adultAddBtn: UIButton!
    @IBOutlet weak var adultMinusBtn: UIButton!
    
    @IBOutlet weak var childAddBtn: UIButton!
    
    @IBOutlet weak var childMinusBtn: UIButton!
    
    @IBOutlet weak var infantAddBtn: UIButton!
    
    @IBOutlet weak var infantMinusBtn: UIButton!
    
    @IBOutlet weak var firstClsBtn: UIButton!
    
    @IBOutlet weak var businessClsBtn: UIButton!
    
    @IBOutlet weak var economyClsBtn: UIButton!
    
    @IBOutlet weak var preEconomyClsBtn: UIButton!
    var adultCnt : Int = Int()
    var childCnt : Int = Int()
    var infantCnt : Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adultCnt = 1
        childCnt = 0
        infantCnt = 0
      
        adultAddBtn.borderColor  = UIColor.gray
        adultAddBtn.layer.cornerRadius = 5
        adultAddBtn.clipsToBounds = true
        
        adultMinusBtn.borderColor  = UIColor.gray
        adultMinusBtn.borderWidth  = 1.0
        adultMinusBtn.layer.cornerRadius = 5
        adultMinusBtn.clipsToBounds = true
       
        childAddBtn.borderColor  = UIColor.gray
        childAddBtn.layer.cornerRadius = 5
        childAddBtn.clipsToBounds = true
        
        childMinusBtn.borderColor  = UIColor.gray
        childMinusBtn.borderWidth  = 1.0
        childMinusBtn.layer.cornerRadius = 5
        childMinusBtn.clipsToBounds = true
        
        infantAddBtn.borderColor  = UIColor.gray
        infantAddBtn.layer.cornerRadius = 5
        infantAddBtn.clipsToBounds = true
        
        infantMinusBtn.borderColor  = UIColor.gray
        infantMinusBtn.borderWidth  = 1.0
        infantMinusBtn.layer.cornerRadius = 5
        infantMinusBtn.clipsToBounds = true
    }

   
    @IBAction func adultAddBtn(_ sender: Any)
    {
        if adultCnt + childCnt < 9
        {
            adultCnt = adultCnt + 1
        }
        lblAdult . text = "\(adultCnt)" + " Adults"
    }
    
    @IBAction func adultRemoveBtn(_ sender: Any)
    {
        if adultCnt  > 1
        {
            adultCnt = adultCnt - 1
        }
        lblAdult . text = "\(adultCnt)" + " Adults"
    }
    
    @IBAction func childAddBtn(_ sender: Any)
    {
        if adultCnt + childCnt < 9
        {
            childCnt = childCnt + 1
        }
        lblChild . text = "\(childCnt)" + " Child"
    }
    
    @IBAction func childRemoveBtn(_ sender: Any)
    {
        if  childCnt > 0
        {
            childCnt = childCnt - 1
        }
        lblChild . text = "\(childCnt)" + " Child"
    }
    
    @IBAction func infantAddBtn(_ sender: Any)
    {
        if adultCnt > infantCnt
        {
            infantCnt = infantCnt + 1
        }
        lblInfant . text = "\(infantCnt)" + " Infant"
    }
    
    @IBAction func infantRemoveBtn(_ sender: Any)
    {
        if infantCnt > 0
        {
            infantCnt = infantCnt - 1
        }
        lblInfant . text = "\(infantCnt)" + " Infant"
    }
    @IBAction func chooseClassBtn(_ sender: Any)
    {
        guard let button = sender as? UIButton else {
            return
        }
        switch button.tag {
        case 1:
            self.firstClsBtn .setImage(UIImage (named: "circleWithDot"), for: UIControl.State.normal)
            self.businessClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
            self.economyClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
            self.preEconomyClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        case 2:
        self.businessClsBtn .setImage(UIImage (named: "circleWithDot"), for: UIControl.State.normal)
        self.firstClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        self.economyClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        self.preEconomyClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        case 3:
        self.economyClsBtn .setImage(UIImage (named: "circleWithDot"), for: UIControl.State.normal)
        self.businessClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        self.firstClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        self.preEconomyClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        case 4:
        self.preEconomyClsBtn .setImage(UIImage (named: "circleWithDot"), for: UIControl.State.normal)
        self.businessClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        self.economyClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        self.firstClsBtn .setImage(UIImage (named: "circleRed"), for: UIControl.State.normal)
        default:
            return
        }
        
    }
    
    @IBAction func confirmBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
