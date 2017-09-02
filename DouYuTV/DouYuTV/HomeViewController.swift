//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - 懒加载属性
    var pageTitleView:PageTitleView {
        
        let titleFrame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 40)
        let titles = ["推荐","手游","娱乐","游戏","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }
    
    var pageContentView : PageContentView {
        
        //MARK: - 设置ContentView的Frame
        let contentFrame = CGRect(x: 0, y: 64 + 40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 40)
        
        //MARK: - 设置所有的子控制器
        var childViews = [UIViewController]()
        for _ in 0..<5 {
            let cvController = UIViewController()
            cvController.view.backgroundColor = UIColor.randomColor
            childViews.append(cvController)
        }
        let contentView = PageContentView(frame: contentFrame, childViews: childViews, parentViewController: self)
        return contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - 设置导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        //MARK: - 加载UI控件
        loadUI()
        
    }
    //MARK: - 加载UI视图方法
    func loadUI()  {
        
        //MARK: - 取消子View内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //MARK: - 加载navigationBar控件
        loadNavigationBar()
        
        //MARK: - 加载pageTitleView控件
        view.addSubview(pageTitleView)
        
        //MARK: - 加载PageContentView控件
        view.addSubview(pageContentView)
        
    }
    //MARK: - 加载navigationBar控件方法
    func loadNavigationBar() {
        
        let size = CGSize(width: 40, height: 40)
        
        //MARK: - 创建左侧BarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImage: "homeLogoIcon")
        
        //MARK: - 创建右侧BarButtonItem
        let gameItem = UIBarButtonItem(normalImage: "home_newGameicon", highlightedImage: "home_newGameicon_clicked", size: size)
        navigationItem.rightBarButtonItems = [gameItem]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK: - PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.syncCurrentIndex(currentIndex: index)
    }

}
