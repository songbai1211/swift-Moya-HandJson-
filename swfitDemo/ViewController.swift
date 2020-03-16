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
            NetWrokManager.reqeust(MultiTarget(DouBan.channels), SuccessClosure: { (model:DouModels) in
                self.channels = model.channels
                self.tableView.reloadData()
            }) { (error) in
                
            }
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
        
        NetWrokManager.reqeust(MultiTarget(DouBan.playlist(chnnelID)), SuccessClosure: { (model:douBanSongModel) in
            let songDetailModel = model.song.first
            self.showAlter(title: songDetailModel?.title ?? "暂无", message: songDetailModel?.artist ?? "暂无")
        }) { (error) in
            
        }
    }
    
    
    func showAlter(title:String,message:String) {
        let alterController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alterController.addAction(UIAlertAction.init(title: "确定", style: .cancel, handler: nil))
        self.present(alterController,animated: true,completion: nil)
    }
    
}




