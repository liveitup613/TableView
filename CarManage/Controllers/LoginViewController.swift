//
//  LoginViewController.swift
//  CarManage
//
//  Created by GOgi on 4/6/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import UIKit
import RAGTextField
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: RAGTextField!
    @IBOutlet weak var txtPassword: RAGTextField!
    @IBOutlet weak var imgLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo.layer.borderWidth = 3
        imgLogo.layer.masksToBounds = false
        imgLogo.layer.borderColor = UIColor.gray.cgColor
        imgLogo.layer.cornerRadius = imgLogo.frame.height/2
        imgLogo.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let sLogin = defaults.string(forKey: "loged") {
            let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            return
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        //let email = txtEmail.text!
        //let password = txtPassword.text!
        let email = "alivesoftsnowman@outlook.com"
        let password = "xincheng1201"
        
        
        
        if !isValidEmail(testStr: email) {
            let alert = UIAlertController(title: "Alert", message: "Your email address is incorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                let _ = self.txtEmail.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)

            return
        }

        if password.count < 6 {
            let alert = UIAlertController(title: "Alert", message: "Please enter more than 7 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                let _ = self.txtPassword.becomeFirstResponder()
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }


        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"

        ApiManager.shared.login(body : ["email": email, "password": password], completion: {
            error, response in

            if error != nil {
                //error
            } else {
//                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                MBProgressHUD.hide(for: self.view, animated: true)

                let res = response as! [String: Any]
                let message = res["message"] as! String
                if message == "fail" {
                    let alert = UIAlertController(title: "Warning", message: "Login Failed!! failed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                if message == "success" {
                    let user = res["user"] as! [String: Any]
                    GlobalData.myAccount = UserModel(dic: user)
                    
                    let defaults = UserDefaults.standard
                    defaults.set("loged", forKey: "loged")
        
                    let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(homeView, animated: true)
                } else {
                    let alert = UIAlertController(title: "Warning", message: "Login Failed!!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        })

        
    }
    
    @IBAction func onSingupClicked(_ sender: Any) {
    }
    
}
