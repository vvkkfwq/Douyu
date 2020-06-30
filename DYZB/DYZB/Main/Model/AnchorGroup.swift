//
//  AnchorGroup.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/30.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组中对应的房间信息
    @objc var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 显示主标题
    @objc var tag_name : String = ""
    /// 组显示的图标
    @objc var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
