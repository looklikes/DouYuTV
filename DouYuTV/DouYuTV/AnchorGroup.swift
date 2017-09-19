//
//  AnchorGroup.swift
//  DouYuTV
//
//  Created by Apple on 2017/9/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    var room_list : [[String : NSObject]]?  {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    var list : [[String : NSObject]]? {
        didSet {
            guard let list = list else {return}
            for dict in list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    var cateInfo : [String:NSObject]?
    var tag_name : String = ""
    var small_icon_url : String = "home_header_normal"
    
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
