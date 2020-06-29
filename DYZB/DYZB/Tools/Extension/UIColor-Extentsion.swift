//
//  UIColor-Extentsion.swift
//  DYZB
//
//  Created by Vickey Feng on 2020/6/15.
//  Copyright © 2020 Vickey Feng. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green:  g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
