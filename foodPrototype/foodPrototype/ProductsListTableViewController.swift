//
//  ProductsListTableViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 2..
//  Copyright © 2018년 송. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ProductsListTableViewController: UITableViewController, AddProductsTableViewControllerDelegate {
    
    private var productLists = [Product]()
    private var rootRef :DatabaseReference!
    
 /*   func addProductsTableViewControllerDidSave(controller: UIViewController, product: Product) {
        controller.dismiss(animated: true, completion: nil)
        let productList = Product(name :product.name, title :product.title, price :product.price)
        self.productLists.append(productList)
        
        let childRef = self.rootRef.child(productList.name)

        childRef.setValue(productList.toDictionary()) //firebase

        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }*/
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootRef = Database.database().reference()
        populateProductLists()

    }
    
    private func populateProductLists(){
        self.rootRef.observe(.value){ snaphot in
            
            self.productLists.removeAll()
            
            let productListDictionary = snaphot.value as? [String:Any] ?? [:]
            
            for (key,_) in productListDictionary {
                if let productListDictionary = productListDictionary[key] as? [String:Any]{
                    
                    if let productList = Product(productListDictionary){
                        self.productLists.append(productList)
                    }
                    
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func addProductsTableViewControllerDidCancel(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell", for: indexPath)
        let productList = self.productLists[indexPath.row]
        cell.textLabel?.text = productList.name
        cell.textLabel?.text = productList.price
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productLists.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddProductsListTableViewController" {
            
            let nc = segue.destination as! UINavigationController
            let addProductsListVC = nc.viewControllers.first as! AddProductsTableViewController
            addProductsListVC.delegate = self
            
        }else if segue.identifier == "DetailedTableViewController"{
            
            guard let indexPath = self.tableView.indexPathForSelectedRow else{
                return
            }
            let detailedTVC = segue.destination as! DeatiledTableViewController
            detailedTVC.productList = self.productLists[indexPath.row]
        }
    }

}
