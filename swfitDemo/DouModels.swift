//
//  DouBanModel.swift
//  swfitDemo
//
//  Created by zhangsongbai on 2020/3/15.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import HandyJSON

class DouModels: HandyJSON {
    var channels = [DouBanModel]()
    required init(){
          
      }
}

class DouBanModel: HandyJSON {
    var abbr_en: String!
    var channel_id: Int!
    var name: String!
    var name_en: String!
    var seq_id: Int!
    
    required init(){
        
    }
}

