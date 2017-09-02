//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class HomeViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        loadUI()
    }
    func loadUI()  {
        loadNavigationBar()
    }
    func loadNavigationBar()  {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
