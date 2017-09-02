//
//  UIBarButtonItemExtension.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/2.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    //新增UIBarButtonItem便利构造函数
    convenience init(normalImage:String,highlightedImage:String = "",size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named:normalImage), for: .normal)
        if highlightedImage != "" {
            btn.setImage(UIImage(named:highlightedImage), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
