//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import UIKit

protocol PageTitleViewDelegate : class {
    
    func pageTitleView(titleView : PageTitleView,selectedIndex index : Int)
}

//MARK: - 滚动条的粗细
private let scrollbarHeight:CGFloat = 3

class PageTitleView: UIView {
    
    //MARK: - 定义属性
    var currentIndex : Int = 0
    var titles:[String]
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollbarLine : UIView = {
        let scrollbarLine = UIView()
        scrollbarLine.backgroundColor = UIColor.orange
        return scrollbarLine
    }()
    
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        loadPageTitleView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension PageTitleView {
    
    func loadPageTitleView() {
        
        //MARK: - 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //MARK: - 添加Title对应的Label
        loadTitleLabel()
        
        //MARK: - 添加滚动条滑块
        loadScrollbar()
    }
    
    //MARK: - 添加Title对应的Label方法
    func loadTitleLabel()  {
        for (index,title) in titles.enumerated() {
            
            //MARK: - label的frame固定值
            let labelW:CGFloat = frame.width / CGFloat(titles.count)
            let labelH:CGFloat = frame.height - scrollbarHeight
            let labelY:CGFloat = 0
            
            //MARK: - 创建label
            let label = UILabel()
            
            //MARK: - 设置label
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //MARK: - 设置label的frame
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //MARK: - 将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //MARK: - 添加label手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.clickTitleLabel(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    //MARK: - 添加滚动条滑块方法
    private func loadScrollbar()  {
        //MARK: - 创建滚动条
        let scrollbar = UIView()
        scrollbar.backgroundColor = UIColor.lightGray
        let barH:CGFloat = 0.1
        scrollbar.frame = CGRect(x: 0, y: frame.height - barH, width: frame.width, height: barH)
        addSubview(scrollbar)
        
        //MARK: - 获取titleLabels属性
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        
        //MARK: - 添加滚动条滑块
        scrollView.addSubview(scrollbarLine)
        scrollbarLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollbarHeight, width: firstLabel.frame.width, height: scrollbarHeight)
    }

}

//MARK: - 监听label的点击
extension PageTitleView {
    
    @objc func clickTitleLabel(tapGes : UITapGestureRecognizer) {
        
        //MARK: - 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        //MARK: - 获取之前label的Index
        let formerlyLabel = titleLabels[currentIndex]
        
        //MARK: - 切换文字颜色
        currentLabel.textColor = UIColor.orange
        formerlyLabel.textColor = UIColor.darkGray
        
        //MARK: - 保存最新的label的Index
        currentIndex = currentLabel.tag
        
        //MARK: - 滚动条滑块与label同步
        let scrollbarLocation = CGFloat(currentLabel.tag) * scrollbarLine.frame.width
        UIView.animate(withDuration: 0.3) {
            self.scrollbarLine.frame.origin.x = scrollbarLocation
        }
        
        //MARK: - 通知代理传递label的Index
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

