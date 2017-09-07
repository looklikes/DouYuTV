//
//  NormalCollectionCell.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/7.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class NormalCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var normalCollectionImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        normalCollectionImage.layer.cornerRadius = 5
        normalCollectionImage.layer.masksToBounds = true
    }

}
