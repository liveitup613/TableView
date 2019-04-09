//
//  ApiManager.swift
//  CarManage
//
//  Created by GOgi on 4/8/19.
//  Copyright © 2019 xincheng. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    
    init() {
        print("ApiManager init")
    }
    
    func login(body: [String: Any], completion: @escaping(Error?, Any?)->()) {
        let url  = "http://206.189.229.7/index.php/mobileapi/loginuser"
        
        Alamofire.request(url, method: .post, parameters: body, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getCategory(completion: @escaping(Error?, Any?) -> ()) {
        let url = "http://206.189.229.7/index.php/mobileapi/get_category_list"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
