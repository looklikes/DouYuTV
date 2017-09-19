//
//  AnchorModel.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    var room_id : String = ""
    var vertical_src : String = ""
    var isVertical : Int = 0
    var room_name : String = ""
    var nickname : String = ""
    var online : Int = 0
    
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
    }
    
}
