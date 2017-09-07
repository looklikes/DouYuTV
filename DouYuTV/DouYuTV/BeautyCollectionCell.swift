//
//  BeautyCollectionCell.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/7.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class BeautyCollectionCell: UICollectionViewCell {

    @IBOutlet weak var beautyCollectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        beautyCollectionImage.layer.cornerRadius = 5
        beautyCollectionImage.layer.masksToBounds = true
    }

}
