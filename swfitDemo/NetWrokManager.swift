//
//  NetWrokManager.swift
//  swfitDemo
//
//  Created by zhangsongbai on 2020/3/15.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
struct  NetWrokManager {
    
    static let provider = MoyaProvider<MultiTarget>(plugins:[
        RequestLoadingPlugin(),AuthPlugin(token: "123456")
    ])
    static func reqeust(_ target:MultiTarget,
                        success successCallBack: @escaping (String) -> Void,
                        failure failureCallBack: @escaping (MoyaError) -> Void
    ){
        provider.request(target) { (result) in
            switch result{
            case let .success(response):
                    let data =  String(data: response.data, encoding: .utf8)
                    guard let json = data else {
                        return
                    }
                    successCallBack(json)
            case let .failure(error):
                failureCallBack(error)
            }
        }
    }
    
}


extension Response{
    func mapJsonToModel<T:HandyJSON>(type: T.Type) -> T {
        let jsonString = String(data: data, encoding: .utf8)
        if let modelT = JSONDeserializer<T>.deserializeFrom(json: jsonString) {
            return modelT
        }
        return JSONDeserializer<T>.deserializeFrom(json: "{\"msg\":\"请求有误\"}")!
    }
}
