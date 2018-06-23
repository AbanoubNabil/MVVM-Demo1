//
//  NetworkServiceLayer.swift
//  MojazTask
//
//  Created by Sayed Abdo on 5/27/18.
//  Copyright © 2018 Bombo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkServiceLayer: NSObject {
    
    func fetchRequest(completion: @escaping (JSON) -> Void , myurl : String , indx : Int) {
        
        guard let url = URL(string: myurl) else {
            completion(JSON.null)
            return
        }
        
        Alamofire.request(url,method: .post, parameters: ["PageSize": "10","PageIndex":"\(indx)","DepartmentID":"2"],encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print(" Error while fetching remote rooms: \(String(describing:response.result.error))")
                completion(JSON.null)
                return
            }
            
            let json = JSON(response.value ?? JSON.null)
            print(json)
            completion(json)
            
            }
    }
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
