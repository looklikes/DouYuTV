//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

// 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(pageTitleView : PageTitleView, didSelectedIndex index : Int)
}

    private let scrollLineH:CGFloat = 3
    private let titleMargin:CGFloat = 80

    private let normalRGB : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
    private let selectRGB : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
    private let deltaRGB = (selectRGB.0 - normalRGB.0, selectRGB.1 - normalRGB.1, selectRGB.2 - normalRGB.2)
    private let normalTitleColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
    private let selectTitleColor = UIColor(red: 255.0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)

class PageTitleView: UIView {
    
    var isScrollEnable : Bool
    var titles : [String]
    lazy var titleLabels : [UILabel] = [UILabel]()
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    // MARK:- 构造函数
    init(frame: CGRect, isScrollEnable : Bool, titles : [String]) {
        
        self.isScrollEnable = isScrollEnable
        self.titles = titles
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = selectTitleColor
        return scrollLine
    }()
    private func setupUI() {
        // 1.添加scrollView
        addSubview(scrollView)
        // 2.初始化labels
        setupTitleLabels()
        // 3.添加定义的线段和滑动的滑块
        setupBottomlineAndScrollline()
    }
    private func setupTitleLabels() {
        let titleY : CGFloat = 0
        let titleH : CGFloat = bounds.height - scrollLineH
        let count = titles.count
        for (index, title) in titles.enumerated() {
            // 1.创建Label
            let label = UILabel()
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.textAlignment = .center
            label.textColor = normalTitleColor
            label.font = UIFont.systemFont(ofSize: 16.0)
            titleLabels.append(label)
            // 3.设置label的frame
            var titleW : CGFloat = 0
            var titleX : CGFloat = 0
            if !isScrollEnable {
                titleW = bounds.width / CGFloat(count)
                titleX = CGFloat(index) * titleW
            } else {
                
                let maxSize: CGSize = CGSize(width: CGFloat(MAXFLOAT), height: 0)
                let attributes : [String : Any] = [NSFontAttributeName : label.font]
                let size = (title as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                
                titleW = size.width
                if index != 0 {
                    titleX = titleLabels[index - 1].frame.maxX + titleMargin
                }
            }
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            // 4.将Label添加到父控件中
            scrollView.addSubview(label)
            // 5.监听label的点击
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func setupBottomlineAndScrollline() {
        // 1.添加bottomline
        let bottomline = UIView()
        bottomline.frame = CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5)
        bottomline.backgroundColor = UIColor.lightGray
        addSubview(bottomline)
        // 2.设置滑块的view
        addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else { return }
        let lineX = firstLabel.frame.origin.x
        let lineY = bounds.height - scrollLineH
        let lineW = firstLabel.frame.width
        let lineH = scrollLineH
        scrollLine.frame = CGRect(x: lineX, y: lineY, width: lineW, height: lineH)
        firstLabel.textColor = selectTitleColor
    }
    
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        // 1.获取点击的下标志
        guard let view = tapGes.view else { return }
        let index = view.tag
        // 2.滚到正确的位置
        scrollToIndex(index: index)
        // 3.通知代理
        delegate?.pageTitleView(pageTitleView: self, didSelectedIndex: index)
    }
    
    // 内容滚动
    private func scrollToIndex(index : Int) {
        // 1.获取最新的label和之前的label
        let newLabel = titleLabels[index]
        let oldLabel = titleLabels[currentIndex]
        // 2.设置label的颜色
        newLabel.textColor = selectTitleColor
        oldLabel.textColor = normalTitleColor
        // 3.scrollLine滚到正确的位置
        let scrollLineEndX = scrollLine.frame.width * CGFloat(index)
        UIView.animate(withDuration: 0.3) {
            self.scrollLine.frame.origin.x = scrollLineEndX
        }
        // 4.记录index
        currentIndex = index
    }
}

// MARK:- 对外暴露方法
extension PageTitleView {
    func setCurrentTitle(sourceIndex : Int, targetIndex : Int, progress : CGFloat) {
        
        // 1.取出两个Label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        // 2.移动scrollLine
        let moveMargin = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveMargin * progress
        
        // 3.颜色渐变
        sourceLabel.textColor = UIColor(red: (selectRGB.0 - deltaRGB.0 * progress) / 255.0, green: (selectRGB.1 - deltaRGB.1 * progress) / 255.0, blue: (selectRGB.2 - deltaRGB.2 * progress) / 255.0, alpha: 1.0)
        targetLabel.textColor = UIColor(red: (normalRGB.0 + deltaRGB.0 * progress)/255.0, green: (normalRGB.1 + deltaRGB.1 * progress)/255.0, blue: (normalRGB.2 + deltaRGB.2 * progress)/255.0, alpha: 1.0)
    }
}


