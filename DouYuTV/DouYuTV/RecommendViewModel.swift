//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/16.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import Alamofire


class RecommendViewModel {
    //MARK: - 懒加载属性
    lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()

}

//MARK : - 请求数据
extension RecommendViewModel {
    

    func requestData()  {
        
        //MARK : - 请求Banner数据
        requestBanner()
        //MARK : - 请求最热数据
        requestFirst()
        //MARK : - 请求颜值数据
        requestSecond()
        //MARK : - 请求综合数据
        requestThirdly()
        
    }
    //MARK : - 请求最热数据方法
    func requestFirst() {
        let url = "https://capi.douyucdn.cn/api/v1/getbigDataRoom"
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
        
        })
    }
    //MARK : - 请求颜值数据方法
    func requestSecond()  {
        let url = "https://apiv2.douyucdn.cn/live/home/custom?client_sys=ios"
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            //MARK : - 获取解析的字典数据
            guard let result = response.result.value else {return}
            
            //MARK : - result转字典
           
        })
    }
    //MARK : - 请求综合数据方法
    func requestThirdly() {
        let url = "https://capi.douyucdn.cn/api/v1/getHotCate"
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            //MARK : - 获取解析的字典数据
            guard let result = response.result.value else {return}
            //MARK : - result转字典
            guard let resultDict = result as? [String:NSObject] else {return}
            //MARK : - 字典转数组
            guard let dataArry = resultDict["data"] as? [[String:NSObject]] else {return}
            //MARK : - 字典转模型
            for dict in dataArry {
                let group = AnchorGroup(dict: dict)
                self.anchorGroup.append(group)
            }
            for group in self.anchorGroup {
                print(group.tag_name)
                for anchor in group.anchors {
                    print(anchor.nickname)
                }
            }
            
        })
    }
    //MARK : - 请banner数据方法
    func requestBanner() {
        let url = "https://capi.douyucdn.cn/api/v1/slide/6"
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            //MARK : - 获取解析的字典数据
            guard let result = response.result.value else {return}
            
            //MARK : - result转字典
            
        })
    }

}
