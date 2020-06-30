//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/30.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {
    
    //MARK: -定义属性
    
    @IBOutlet weak var srcImageView: UIImageView!
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {return}
            var onLineStr : String = ""
            if anchor.online >= 10000 {
                onLineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onLineStr = "\(anchor.online)在线"
            }
            onLineBtn.setTitle(onLineStr, for: .normal)
            
            roomName.text = anchor.room_name
            nickNameLabel.text = anchor.nickname
            
            let iconURL = URL(string: anchor.vertical_src)
            srcImageView.kf.setImage(with: iconURL)
        }
    }

    
}
