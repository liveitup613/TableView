//
//  HomeViewController.swift
//  CarManage
//
//  Created by GOgi on 4/6/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwipeCellKit



class HomeViewController: UIViewController {
    
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var tviewUser: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tviewUser.layer.masksToBounds = false
        tviewUser.layer.shadowColor = UIColor.black.cgColor
        tviewUser.layer.shadowOffset = CGSize(width: 0, height: 4)
        tviewUser.layer.shadowRadius = 2
        tviewUser.layer.shadowOpacity = 1
        
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        ApiManager.shared.getCategory(completion: {
            error, response in
            
            MBProgressHUD.hide(for: self.view, animated: true)

            let result = response as! [String: Any]
            let message = result["message"] as! String
        
            if message != "success" {
                let alert = UIAlertController(title: "Alert", message: "Failed to load user data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            } else {
                let users = result["data"] as! [[String: Any]]
                
                for user in users {
                    let username = user["name"] as! String
                    GlobalData.userList.append(User(name : username, address : "dandong"))
                }
                
                self.tviewUser.reloadData()
            }
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tviewUser.reloadData()
    }
    
    
    @IBAction func onBackClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func onNextClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onAddPersonClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPersonViewController") as! AddPersonViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onRemoveTapped(_ sender: Any) {
        let button = sender as! UIButton
        let index = button.tag - 10000
        GlobalData.userList.remove(at: index)
        tviewUser.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalData.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.lblName.text = GlobalData.userList[indexPath.row].name
        cell.btnRemove.tag = indexPath.row + 10000//.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }
//
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//
//
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedUser = userList[sourceIndexPath.row]
//        userList.remove(at: sourceIndexPath.row)
//        userList.insert(movedUser, at: destinationIndexPath.row)
//    }
}

//download.jpg
//alivesoftsnowman@outlook.com

extension HomeViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            GlobalData.userList.remove(at: indexPath.row)
            self.tviewUser.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .reveal
//        return options
//    }
}

extension HomeViewController: AddPersonDelegate {
    func addPerson(name: String, address: String) {
        GlobalData.userList.append(User(name : name, address:address))
        tviewUser.reloadData()
    }
}
