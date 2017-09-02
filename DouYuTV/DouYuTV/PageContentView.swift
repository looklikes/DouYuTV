//
//  PageContentView.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //MARK: - 自定义属性
    var childViews : [UIViewController]
    weak var parentViewController : UIViewController?
    
    //MARK: - 懒加载属性
    lazy var collectionView: UICollectionView = {[weak self] in
        
        //MARK: - 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //MARK: - 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,childViews: [UIViewController],parentViewController: UIViewController) {
        
        self.childViews = childViews
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //MARK: - 设置UI界面
        loadPageContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - 设置UI界面
extension PageContentView {
    
    func loadPageContentView() {
        
        //MARK: - 将所有子控制器添加到父控制器中
        for childVC in childViews {
            parentViewController?.addChildViewController(childVC)
        }
        
        //MARK: - 添加UICollectionView,将控制器的View存放在Cell中
        addSubview(collectionView)
        collectionView.frame = bounds
    
    }
}

//MARK: - UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViews.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //MARK: - 创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //MARK: - 给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
    
        let childView = childViews[indexPath.item]
        childView.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childView.view)
        
        return cell
    }
}

//MARK: - 外部方法
extension PageContentView {
    func syncCurrentIndex(currentIndex : Int)  {
        print(currentIndex)
        //MARK: - 滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
