//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/15.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //类方法
    /*
    class func createItem(imageName: String, hightImageName: String, size: CGSize) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    
    //构造方法
    convenience init(imageName: String, hightImageName: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
