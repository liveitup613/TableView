//
//  AddPersonViewController.swift
//  CarManage
//
//  Created by GOgi on 4/7/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import UIKit

public protocol AddPersonDelegate : NSObjectProtocol {
    func addPerson(name: String, address: String)
}

class AddPersonViewController: UIViewController {

    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var delegate: AddPersonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewNavigation.layer.masksToBounds = false
        viewNavigation.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewNavigation.layer.shadowColor = UIColor.black.cgColor
        viewNavigation.layer.shadowRadius = 2
        viewNavigation.layer.shadowOpacity = 1
        // Do any additional setup after loading the view.
        
        setTextFieldStyle(txtName)
        setTextFieldStyle(txtAddress)
        setTextFieldStyle(txtEmail)
        
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
//        userList.append(User(name : txtName.text!, address:txtAddress.text!))
        delegate?.addPerson(name: txtName.text!, address: txtAddress.text!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onCacelClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setTextFieldStyle(_ myTextField : UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 0.0, width: myTextField.frame.width, height: myTextField.frame.height - 2)
        bottomLine.backgroundColor = UIColor.white.cgColor
        myTextField.layer.addSublayer(bottomLine)
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

