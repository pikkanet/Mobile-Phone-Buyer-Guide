//
//  ViewController.swift
//  Mobile Phone Buyer Guide
//
//  Created by Pikkanet Chokwattanapornchai on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {
    
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
//            print(result)
            self.mDataArray = result
            print(self.mDataArray.count)
            
        }
    }


}

