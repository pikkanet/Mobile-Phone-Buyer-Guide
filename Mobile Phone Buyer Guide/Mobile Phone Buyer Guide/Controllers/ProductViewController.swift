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

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyCellDelegate {
    
    @IBOutlet weak var mTableView:UITableView!
    
    var mDataArray:MobileResponse = []
    var mFeedData:FeedData = FeedData()
    var selectedIndex:Int?
    var id:Int?

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
        self.mFeedData.getMobiles(url: url) { (result) in
            self.mDataArray = result
            for i in 0...self.mDataArray.count-1 {
                self.mDataArray[i].isFavourite = false
                print(i)
            }
            self.mTableView.reloadData()
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(self.mDataArray.count)
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mobilecell", for: indexPath) as! CustomTableViewCell
        let item = self.mDataArray[indexPath.row]
        print(self.mDataArray[indexPath.row].isFavourite)
        if item.isFavourite!{
            let image = UIImage(named: "fav")
            cell.mFavoriteButton.setImage(image, for: .normal)
        } else{
            let image = UIImage(named: "unfav")
            cell.mFavoriteButton.setImage(image, for: .normal)
        }
        cell.delegate = self as! MyCellDelegate
        cell.mFavoriteButton.tag = indexPath.row
        cell.mProductName.text = item.name
        cell.mProductDescription.text = item.mobileResponseDescription
        cell.mProductRate.text = "Rating: \(item.rating)"
        cell.mProductPrice.text = "Price: $\(item.price)"
        cell.mProductImage.af_setImage(withURL: URL(string: item.thumbImageURL)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.mDataArray[indexPath.row]
        self.selectedIndex = indexPath.row
        self.id = item.id
        print(indexPath.row)
//        let url =  "https://scb-test-mobile.herokuapp.com/api/mobiles/\(item.id)/images/"
//        self.mFeedData.getMobileImages(url: url) { (result) in
//            print(result.count)
//        }
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func didTapButtonInCell(_ cell: CustomTableViewCell) {
        print(cell.mFavoriteButton.tag)
        self.mDataArray[cell.mFavoriteButton.tag].isFavourite = true
        self.mTableView.reloadData()
//        print("tap")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetVC = segue.destination as! ProductDetailViewController
//        targetVC.message = "Foam"
        print(self.mDataArray[self.selectedIndex!].name)
        targetVC.productName = self.mDataArray[self.selectedIndex!].name
        targetVC.id = self.id
        targetVC.productDescription = self.mDataArray[self.selectedIndex!].mobileResponseDescription
        targetVC.productPrice = "Price: $\(self.mDataArray[self.selectedIndex!].price)"
        targetVC.productRate = "Rating: \(self.mDataArray[self.selectedIndex!].rating)"
    }
    
}


protocol MyCellDelegate: class {
    func didTapButtonInCell(_ cell: CustomTableViewCell)
}
