//
//  ViewController.swift
//  swfitDemo
//
//  Created by crespo on 2020/3/11.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
class ViewController: UIViewController {
    var tableView:UITableView!
    var channels: [Any]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        loadSongListData()
    }
    func loadSongListData(){
        //获取歌曲列表
        
        NetWrokManager.reqeust(MultiTarget(DouBan.channels), success: { (string) in
            if let models = DouModels.deserialize(from: string){
                self.channels = models.channels
                }
                self.tableView.reloadData()
        }) { (error) in
            
        }
        
        
        
        
//        DoubanPrivider.request(.channels) { (result) in
//            switch result{
//            case let .success(response):
//                let jsonString = String.init(data: response.data, encoding: .utf8)
//                guard let json = jsonString else {
//                    return
//                }
//
//            case .failure(_):
//                return
//            }
//        }
    }
    
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.channels!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let model = self.channels?[indexPath.row] as! DouBanModel
        cell.textLabel?.text = model.name + String(model.seq_id)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.channels?[indexPath.row] as! DouBanModel
        getSongDetial(chnnelID: String(model.channel_id))
    }
    
    
    
    
    
    //获取歌曲详情
    func getSongDetial(chnnelID:String){
        
        
        NetWrokManager.reqeust(MultiTarget(DouBan.playlist(chnnelID)), success: { (string) in
            if let  model = douBanSongModel.deserialize(from: string){
           let songDetailModel = model.song.first!
           self.showAlter(title: songDetailModel.title ?? "暂无", message: songDetailModel.artist ?? "暂无")
                          
            }
        }) { (error) in
            
        }
        
        
        
//        DoubanPrivider.request(MultiTarget(DouBan.playlist(chnnelID))) { (result) in
//            switch result{
//            case let .success(response):
//                let json = String(data: response.data, encoding: .utf8)
//                guard let jsonString = json else {
//                    return
//                }
//                if let  model = douBanSongModel.deserialize(from: jsonString){
//                    let songDetailModel = model.song.first!
//                    self.showAlter(title: songDetailModel.title ?? "暂无", message: songDetailModel.artist ?? "暂无")
//                }
//            case .failure(_):
//                return
//            }
//        }
    }
    
    
    func showAlter(title:String,message:String) {
        let alterController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alterController.addAction(UIAlertAction.init(title: "确定", style: .cancel, handler: nil))
        self.present(alterController,animated: true,completion: nil)
    }
    
}




