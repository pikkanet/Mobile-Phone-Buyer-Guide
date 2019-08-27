//
//  ViewController.swift
//  Mobile Phone Buyer Guide
//
//  Created by Pikkanet Chokwattanapornchai on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mTableView:UITableView!
    
    var mDataArray:MobileResponse = []
    var mFeedData:FeedData = FeedData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedData()
        
        // set up navigation bar
        let sort = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(onSort))
        navigationItem.rightBarButtonItems = [sort]
    }
    
    @objc func onSort(){
        print("sort")
    }
    
    func feedData(){
        let url =  "https://scb-test-mobile.herokuapp.com/api/mobiles/"
        self.mFeedData.getPositionData(url: url) { (result) in
            self.mDataArray = result
            self.mTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mobilecell", for: indexPath) as! CustomTableViewCell
        let item = self.mDataArray[indexPath.row]
        cell.mProductName.text = item.name
        cell.mProductDescription.text = item.mobileResponseDescription
        cell.mProductRate.text = "Rating: \(item.rating)"
        cell.mProductPrice.text = "Price: $\(item.price)"
        cell.mProductImage.af_setImage(withURL: URL(string: item.thumbImageURL)!)
        print(item.isFavourite)
        return cell
    }
    
    
}

