//
//  LoginPageVCGoomo.swift
//  TripArcher
//
//  Created by APPLE on 12/03/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

protocol LoginProtocolGoomo {
    func didLoggedIn(selectedString : String ,controller : LoginPageVCGoomo)
}

class LoginPageVCGoomo: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    var loginFrom : String!
    var delegateVariable : LoginProtocolGoomo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("came from :",self.loginFrom)
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if !(Reachability()!.isReachable) {
            print("No Internet from Login..................")
           
        }
        else {
            callLoginService()
        }
    }
    func callLoginService() {
        
        let RequestDict : [String:String] = ["UserName":emailTxtField.text!,"Password":passwordTxtField.text!]
        print("Login Detail from Login..",RequestDict)
        
        WebService().HTTP_POST_WebServiceMethod_Profile(mainURL: WebServicesUrl.MainURL, suffix: WebServicesUrl.Login, parameterDict: RequestDict) { (ResponseDict, ResponseStatus) in
            print("Login Response from LoginPage = ",ResponseDict)
            
            if ResponseStatus {
                print("Service call success ..........")
                let fullResponse = ResponseDict as! [String:String]
                print(fullResponse)
                //                ["Result": "483~2536~mks kalai~123456"]
                
                if (fullResponse["Result"]?.contains("~"))! {
                    print("Contains tilt")
                    let arr = fullResponse["Result"]?.components(separatedBy: "~")
                    
                    var aLoginDetailStruct = LoginDetails()
                    aLoginDetailStruct.Email = self.emailTxtField.text!
                    aLoginDetailStruct.Password = self.passwordTxtField.text!
                    
                    SaveLoginDetailsWithStruct(Struct: aLoginDetailStruct)
                    
                    var aLoginResponseStruct = LoginResponse()
                    aLoginResponseStruct.UserSK = arr![0]
                    aLoginResponseStruct.Name = arr![2]
                    aLoginResponseStruct.PhoneNo = arr![3]
                    
                    SaveLoginResponseWithStruct(Struct: aLoginResponseStruct)
                 
                    if self.loginFrom == "HomePage"{

                        let NavMain = self.storyboard?.instantiateViewController(withIdentifier: "LGSideMenuSBID")
                        self.present(NavMain!, animated: true, completion: nil)
                    }else if self.loginFrom == "FlightReview" {

                        self.delegateVariable.didLoggedIn(selectedString: "hideBtns", controller: self)
                    }else if self.loginFrom == "HotelBooking" {
                        self.delegateVariable.didLoggedIn(selectedString: "hideLoginView", controller: self)
                    }
                    
                    
                }else{
                    print("No tilt")
                   
                }
                
                
            }else{
                print("Service call failure ..........")
                print("Try after sometimes.......")
              
                
                /*  Message.shared.Alert(Title: "", Message: Constants.InternalError, TitleAlign: .normal, MessageAlign: .normal, Actions: [Message.AlertActionWithSelector(Title: "quit", Selector: #selector(self.QuitApp), Controller: self),Message.AlertActionWithSelector(Title: "retry", Selector: #selector(self.CallService), Controller: self)], Controller: self)*/
            }
            
        }
    }
    
    @IBAction func signupBtnTapped(_ sender: UIButton) {
//        let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVCSBID") as! RegisterVC
//        self.navigationController?.pushViewController(ctrl, animated: true)
        //        self.navigationController?.present(ctrl, animated: true, completion: nil)
    }
    
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        if loginFrom == "HomePage"{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
        //        self.navigationController?.dismiss(animated: true, completion: nil)
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
extension LoginPageVCGoomo : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
