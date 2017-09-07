//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/6.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

private let itemMargin : CGFloat = 10
private let itemW : CGFloat = (screenW - 3 * itemMargin) / 2
private let normalItemH : CGFloat = itemW * 3 / 4
private let beautyItemH : CGFloat = itemW * 4 / 3
private let headerViewH : CGFloat = 50
private let normalCellID : String = "normalCellID"
private let beautyCellID : String = "beautyCellID"
private let headerViewID : String = "headerViewID"

class RecommendViewController: UIViewController {
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
        
        
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: normalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: screenW, height: headerViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //设置collectionView灵活宽高
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "NormalCollectionCell", bundle: nil), forCellWithReuseIdentifier: normalCellID)
        collectionView.register(UINib(nibName: "BeautyCollectionCell", bundle: nil), forCellWithReuseIdentifier: beautyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        collectionView.backgroundColor = UIColor(white: 1, alpha: 1)
        
        return collectionView
        }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(collectionView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell : UICollectionViewCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: beautyCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellID, for: indexPath)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: itemW, height: beautyItemH)
        }
        
        return CGSize(width: itemW, height: normalItemH)
    }
    
}
