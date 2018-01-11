//
//  Utility+String.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/2.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

extension Utility where Base: Collection {
    
    public var hex: UIColor {
        return stringTransformToHexColor()
    }
    
    public var img: UIImage? {
        return UIImage(named: String(describing: base))
    }
}

extension Utility {
    
    fileprivate func stringTransformToHexColor() -> UIColor {
        
        let hexStr = String(describing: base)
        var str = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if str.characters.count < 6 {
            return UIColor.clear
        }
        if str.hasPrefix("0X") {
            str.removeFirst(2)
        }
        if str.hasPrefix("#") {
            str.removeFirst()
        }
        if str.characters.count != 6 {
            return UIColor.clear
        }
        
        let strs = Array(str)
        
        let rString = String(strs[0..<2])
        let gString = String(strs[2..<4])
        let bString = String(strs[4..<6])
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}

