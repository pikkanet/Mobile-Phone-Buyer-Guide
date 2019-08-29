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
    @IBOutlet weak var mAllButton:UIButton!
    @IBOutlet weak var mFavouriteButton:UIButton!
    
    var mDataArray:MobileResponse = []
    var mFavoriteArray:MobileResponse = []
    var tmp:MobileResponse = []
    var mFeedData:FeedData = FeedData()
    var selectedIndex:Int?
    var id:Int?
    var isFavorite:Bool? = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedData()
        
        // set up navigation bar
        let sort = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(onSort))
        navigationItem.rightBarButtonItems = [sort]
    }
    
    @objc func onSort(){
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: {(_: UIAlertAction!) in
            print("Price low to high")
            self.mDataArray.sort(by: { $0.price < $1.price })
            self.mTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: {(_: UIAlertAction!) in
            print( "Price high to low")
            self.mDataArray.sort(by: { $0.price > $1.price })
            self.mTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: {(_: UIAlertAction!) in
            print("Rating")
            self.mDataArray.sort(by: { $0.rating > $1.rating })
            self.mTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
        self.present(alert, animated: true)
    }
    
    func feedData(){
        let url =  "https://scb-test-mobile.herokuapp.com/api/mobiles/"
        self.mFeedData.getMobiles(url: url) { (result) in
            self.mDataArray = result
            for i in 0...self.mDataArray.count-1 {
                self.mDataArray[i].isFavourite = false
            }
            self.mTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mobilecell", for: indexPath) as! CustomTableViewCell
        let item = self.mDataArray[indexPath.row]
        if item.isFavourite!{
            let image = UIImage(named: "fav")
            cell.mFavoriteButton.setImage(image, for: .normal)
        } else{
            let image = UIImage(named: "unfav")
            cell.mFavoriteButton.setImage(image, for: .normal)
        }
        if self.isFavorite! {
            cell.mFavoriteButton.isHidden = true
        } else {
            cell.mFavoriteButton.isHidden = false
        }
        cell.delegate = self as MyCellDelegate
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
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
            self.mDataArray[indexPath.row].isFavourite = false
            print(self.mDataArray[0].isFavourite)
            self.mTableView.reloadData()
        }
    }
    
//    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//
//
//
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if(self.isFavorite!){
            return UITableViewCell.EditingStyle.delete
        }
        return UITableViewCell.EditingStyle.none
        
    }
    
    func didTapButtonInCell(_ cell: CustomTableViewCell) {
        print(cell.mFavoriteButton.tag)
        if self.mDataArray[cell.mFavoriteButton.tag].isFavourite!{
            self.mDataArray[cell.mFavoriteButton.tag].isFavourite = false
        } else {
            self.mDataArray[cell.mFavoriteButton.tag].isFavourite = true
        }
        self.mTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetVC = segue.destination as! ProductDetailViewController
        print(self.mDataArray[self.selectedIndex!].name)
        targetVC.productName = self.mDataArray[self.selectedIndex!].name
        targetVC.id = self.id
        targetVC.productDescription = self.mDataArray[self.selectedIndex!].mobileResponseDescription
        targetVC.productPrice = "Price: $\(self.mDataArray[self.selectedIndex!].price)"
        targetVC.productRate = "Rating: \(self.mDataArray[self.selectedIndex!].rating)"
    }
    
    @IBAction func onClickAll(_ sender: Any) {
        self.isFavorite = false
        self.mDataArray = self.tmp
        self.mTableView.reloadData()
        self.mAllButton.alpha = 0.78
        self.mFavouriteButton.alpha = 0.38
    }
    
    @IBAction func onClickFavorite(_ sender: Any) {
        self.isFavorite = true
        self.mFavoriteArray = self.mDataArray.filter{(data) -> Bool in
            return data.isFavourite == true
        }
        self.tmp = self.mDataArray
        self.mDataArray = self.mFavoriteArray
        self.mTableView.reloadData()
        self.mAllButton.alpha = 0.38
        self.mFavouriteButton.alpha = 0.78
    }
    
}


protocol MyCellDelegate: class {
    func didTapButtonInCell(_ cell: CustomTableViewCell)
}
