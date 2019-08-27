//
//  ProductDetailViewController.swift
//  Mobile Phone Buyer Guide
//
//  Created by Pikkanet Chokwattanapornchai on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var message:String?
    var id:Int?
    var mFeedData:FeedData = FeedData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = message
//        print(id)
        self.feedData(id!)

        // Do any additional setup after loading the view.
    }
    
    func feedData(_ id: Int){
        let url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(id)/images/"
        self.mFeedData.getMobileImages(url: url) { (result) in
            print(result)
        }
    }

}
