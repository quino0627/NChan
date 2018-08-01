//
//  ProductListViewController.swift
//  foodPrototype
//
//  Created by cscoi007 on 2018. 8. 1..
//  Copyright © 2018년 송. All rights reserved.
//

import UIKit

struct Product {
    var title: String
    var price: String
    var image: String
    var time: String
    var number: String
    var tag: String
}


class ProductListViewController: UIViewController, UITableViewDataSource {
  
    var data = [
        Product(title: "더반찬", price: "20000원", image: "pic__thebanchan",time: "3시간전", number: "(3/4)", tag: "#닭강정"),
        Product(title: "더반찬", price: "20000원", image: "pic__thebanchan",time: "3시간전", number: "(3/4)", tag: "#닭강정"),
        Product(title: "더반찬", price: "20000원", image: "pic__thebanchan",time: "3시간전", number: "(3/4)", tag: "#닭강정")
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GongguCell", for: indexPath) as! GongguCell
        
        let item = data[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.priceLabel.text = item.price
        cell.imageLabel.image = UIImage(named: item.image)
        cell.numberLabel.text = item.number
        cell.tagLabel.text = item.tag
        cell.timeLabel.text = item.time
        
        
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
