//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: statusBarH + navigationBarH, width: screenW, height: titleViewH)
        let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, isScrollEnable: false, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        
        // 1.确定内容的frame
        let contentH = screenH - statusBarH - navigationBarH - titleViewH - tabbarH
        let contentFrame = CGRect(x: 0, y: statusBarH + navigationBarH + titleViewH, width: screenW, height: contentH)
        
        //MARK: - 设置所有的子控制器
        var childVcs = [UIViewController]()
        let recommendVC = RecommendViewController()
        childVcs.append(recommendVC)
        for _ in 0..<4 {
            let cvController = UIViewController()
            cvController.view.backgroundColor = UIColor.randomColor()
            childVcs.append(cvController)
        }

        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
    }
    
}


// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavigationBar() {
        
        // 0.设置NavigationBar背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        // 1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
        
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 44)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        let gameItem = UIBarButtonItem(imageName: "home_newGameicon", highImageName: "home_newGameicon_clicked", size: size)
        navigationItem.rightBarButtonItems = [historyItem,gameItem]
    }
}


// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(pageTitleView titleView: PageTitleView, didSelectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setCurrentTitle(sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}

