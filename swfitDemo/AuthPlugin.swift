//
//  AuthPlugin.swift
//  swfitDemo
//
//  Created by zhangsongbai on 2020/3/15.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import Moya

class TokenSource {
    var token: String?
    init() {
        
    }
}
protocol AuthorizedTaggetType:TargetType {
    var needAuth:Bool{get}
}
struct AuthPlugin: PluginType {
    let token:String
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        guard
           let target = target as? AuthorizedTaggetType,
           target.needAuth
           else {
               return request
            }
        var request = request
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
}
