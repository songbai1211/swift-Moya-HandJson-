//
//  BaseModel.swift
//  swfitDemo
//
//  Created by zhangsongbai on 2020/3/15.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import HandyJSON
class BaseModel<T:HandyJSON>: HandyJSON {

    var code: Int?
    var data: T?
    required init(){
        
    }
}
