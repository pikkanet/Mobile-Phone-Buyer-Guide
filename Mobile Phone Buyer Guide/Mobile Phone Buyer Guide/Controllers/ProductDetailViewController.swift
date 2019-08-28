//
//  ProductDetailViewController.swift
//  Mobile Phone Buyer Guide
//
//  Created by Pikkanet Chokwattanapornchai on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var mCollectionView:UICollectionView!
    @IBOutlet weak var mProductRate:UILabel!
    @IBOutlet weak var mProductPrice:UILabel!
    @IBOutlet weak var mProductDescription:UILabel!
    
    var productName:String?
    var id:Int?
    var mFeedData:FeedData = FeedData()
    var mDataArray:MobileImageResponse = []
    var productDescription, productPrice, productRate:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabel()
        self.title = productName
//        print(id)
        self.feedData(id!)

        // Do any additional setup after loading the view.
    }
    
    func setupLabel(){
        mProductRate.text = productRate
        mProductPrice.text = productPrice
        mProductDescription.text = productDescription
    }
    
    func feedData(_ id: Int){
        let url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(id)/images/"
        self.mFeedData.getMobileImages(url: url) { (result) in
            self.mDataArray = result
            self.mCollectionView.reloadData()
        }
    }

}

extension ProductDetailViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "collectionViewCell",
            for: indexPath) as! ImageCollectionViewCell
        let item = self.mDataArray[indexPath.row]
        cell.mImage.kf.setImage(with: URL(string: item.url))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
}
