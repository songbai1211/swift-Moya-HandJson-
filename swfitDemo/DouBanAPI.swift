//
//  DouBanAPI.swift
//  swfitDemo
//
//  Created by zhangsongbai on 2020/3/15.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import Moya

let DoubanPrivider = MoyaProvider<MultiTarget>()


public enum DouBan {
    case channels
    case playlist(String)
}

extension DouBan: TargetType {
   //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        }
    }
     
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var needAuth:Bool{
        switch self {
        case .channels:
            return true
        case .playlist(_):
            return false
        }
    }
    
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params:[String:Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    

}
