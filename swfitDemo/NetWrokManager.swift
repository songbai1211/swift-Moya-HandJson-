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

typealias SuccessClosure<T:HandyJSON> = (_ type : T) -> ()
typealias FailClosure = (_ error : String?) -> Void

struct  NetWrokManager {
    
    static let provider = MoyaProvider<MultiTarget>(plugins:[
        RequestLoadingPlugin(),AuthPlugin(token: "123456")
    ])
    static func reqeust<T:HandyJSON>(_ target:MultiTarget,
                                     SuccessClosure:@escaping SuccessClosure<T>,
                                     failClosure:@escaping FailClosure
    ){
        provider.request(target) { (result) in
            switch result{
            case let .success(response):
                
                let json = String(data: response.data, encoding: .utf8)
                if let responseObejct = T.deserialize(from: json) {
                    SuccessClosure(responseObejct)
                }else{
                    failClosure("错误信息")
                }
                   
            case let .failure(error):
                failClosure(error.localizedDescription)
            }
        }
    }
}




//
//let requestProvider = RxMoyaProvider<RequestApi>()
//
//func requestDataWithTarget<T: Mappable>(target: RequestApi, type: T.Type , successClosure: SuccessClosure, failClosure: FailClosure) {
//    let _ = requestProvider.request(target).subscribe { (event) -> Void in
//        switch event {
//        case .Next(let response):
//            let info = Mapper<CommonInfo>().map(JSON(data: response.data,options: .AllowFragments).object)
//            guard info?.code == RequestCode.success.rawValue else {
//                failClosure(errorMsg: info?.msg)
//                return
//            }
//            guard let data = info?.data else {
//                failClosure(errorMsg: "数据为空")
//                return
//            }
//            successClosure(result: data)
//        case .Error(let error):
//            print("网络请求失败...\(error)")
//        default:
//            break
//        }
//    }
//}




//extension Response{
//    func mapJsonToModel<T:HandyJSON>(type: T.Type) -> T {
//        let jsonString = String(data: data, encoding: .utf8)
//        if let modelT = JSONDeserializer<T>.deserializeFrom(json: jsonString) {
//            return modelT
//        }
//        return JSONDeserializer<T>.deserializeFrom(json: "{\"msg\":\"请求有误\"}")!
//    }
//}
