//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        //加载UI控件
        loadUI()
    }
    //加载UI视图方法
    func loadUI()  {
        //加载navigationBar控件
        loadNavigationBar()
    }
    //加载navigationBar控件方法
    func loadNavigationBar() {
        
        let size = CGSize(width: 40, height: 40)
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImage: "homeLogoIcon")
        let gameItem = UIBarButtonItem(normalImage: "home_newGameicon", highlightedImage: "home_newGameicon_clicked", size: size)
        navigationItem.rightBarButtonItems = [gameItem]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
