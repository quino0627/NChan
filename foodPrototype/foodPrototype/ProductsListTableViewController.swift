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

class ProductsListTableViewController: UITableViewController, AddProductsTableViewControllerDelegate {

    private var productLists = [ProductList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func addProductsTableViewControllerDidCancel(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func addProductsTableViewControllerDidSave(controller: UIViewController, title: String) {
        //print(title)
        controller.dismiss(animated: true, completion: nil)
        let productList = ProductList(title: title)
        self.productLists.append(productList)
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell", for: indexPath)
        let productList = self.productLists[indexPath.row]
        cell.textLabel?.text = productList.title
        
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
            
        }
    }

}
