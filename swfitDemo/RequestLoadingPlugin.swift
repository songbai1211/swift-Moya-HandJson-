//
//  RequestLoadingPlugin.swift
//  swfitDemo
//
//  Created by zhangsongbai on 2020/3/15.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import Moya
import Result
final class RequestLoadingPlugin: PluginType {

    private var spinner:UIActivityIndicatorView!
    init() {
        self.spinner = UIActivityIndicatorView(style: .gray)
        self.spinner.center = UIApplication.shared.windows.first!.center
    }
    func willSend(_ request: RequestType, target: TargetType) {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first!.addSubview(self.spinner)
            self.spinner.startAnimating()
        }
       print("请求开始")
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        self.spinner.removeFromSuperview()
        self.spinner.stopAnimating()
        print("请求结束")
        guard case let Result.failure(error) = result else { return}
            //弹出并显示错误信息
        let message = error.errorDescription ?? "未知错误"
        let alertViewController = UIAlertController(title: "请求失败",
                                                    message: "\(message)",
                                                    preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "确定", style: .default,
                                                    handler: nil))
//        UIApplication.shared.keyWindow.present(alertViewController, animated: true)

       
    }
    
}
