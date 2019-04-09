//
//  CollectionViewController.swift
//  CarManage
//
//  Created by GOgi on 4/7/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet weak var collectionViewUser: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewNavigation.layer.masksToBounds = false
        viewNavigation.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewNavigation.layer.shadowColor = UIColor.black.cgColor
        viewNavigation.layer.shadowRadius = 2
        viewNavigation.layer.shadowOpacity = 1

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionViewUser.reloadData()
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onRemoveTapped(_ sender: Any) {
        let btnRemove = sender as! UIButton
        
        let alert = UIAlertController(title: "Alert", message: "Do you really want to remove this cell?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            GlobalData.userList.remove(at: btnRemove.tag)
            self.collectionViewUser.reloadData()
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
        
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

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalData.userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        cell.lblName.text = GlobalData.userList[indexPath.row].name
        cell.btnRemove.tag = indexPath.row

        cell.imgLogo.layer.borderColor = UIColor.gray.cgColor
        cell.imgLogo.layer.cornerRadius = cell.imgLogo.frame.height/2
        cell.imgLogo.clipsToBounds = true
        
        	
        return cell
    }
    
    
}

extension CollectionViewController: UICollectionViewDelegate {
    
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = 3
        let paddingSpace = 10 * (itemsPerRow - 1)
        let availableWidth = Int(collectionView.frame.width) - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: 70)
    }
}
