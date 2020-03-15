//
//  DouBanSongInfoModel.swift
//  swfitDemo
//
//  Created by zhangsongbai on 2020/3/15.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import HandyJSON


struct douBanSongModel:HandyJSON {
    var song = [DouBanSongDetalInfoModel]()
    var is_show_quick_start:Int?
}

struct DouBanSongDetalInfoModel:HandyJSON{
    var sid: String?
    var public_time: String?
    var ssid: String?
    var alert_msg: String?
    var artist: String?
    var album: String?
    var aid: String?
    var like: Int = 0
    var title: String?
    var albumtitle: String?
    var length: Int = 0
    var picture: String?
    var kbps: String?
    var sha256: String?
    var url: String?
    var is_douban_playable: Bool = false
    var release: Release?
    var file_ext: String?
    var update_time: Int = 0
    var subtype: String?
    var status: Int = 0
    var is_royal: Bool = false
}


struct Release :HandyJSON{
    var title: String?
    var cover: String?
    var ssid: String?
    var link: String?
    var id: String?
    var singers = [Singers]()
}

struct Singers :HandyJSON{
    var related_site_id: Int = 0
    var genre = [String]()
    var name: String?
    var avatar: String?
    var name_usual: String?
    var region = [String]()
    var is_site_artist: Bool = false
    var id: String?
}

