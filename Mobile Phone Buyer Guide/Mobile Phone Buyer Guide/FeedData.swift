//
//  FeedData.swift
//  Mobile Phone Buyer Guide
//
//  Created by Pikkanet Chokwattanapornchai on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Alamofire
import Foundation

class FeedData {
    
    func getPositionData(url: String, completion: @escaping (MobileResponse) -> Void){
        var request = URLRequest(url: NSURL.init(string: url)! as URL)
        request.httpMethod = "GET"
        AF.request(request).responseJSON { response in
            switch response.result {
            case let .success(value):
                //                print(value)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MobileResponse.self, from: response.data!)
                    completion(result)
                } catch let error{
                    print(error)
                    completion(error as! MobileResponse)
                }
                break
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    
}
