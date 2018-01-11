//
//  Utility+FitScreen.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/2.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

/// 屏幕适配
extension Utility where Base: FitCompatible {
    
    ///vertical pixels
    public var vpx: CGFloat {
        return base.value * UIScreen.main.bounds.height/1334
    }
    
    ///horizontal pixels
    public var hpx: CGFloat {
        return base.value * UIScreen.main.bounds.width/750
    }
}

public protocol FitCompatible {
    var value: CGFloat { get }
}

extension CGFloat: FitCompatible {
    public var value: CGFloat { return self }
}

extension Int: FitCompatible {
    public var value: CGFloat { return CGFloat(self) }
}

extension Double: FitCompatible {
    public var value: CGFloat { return CGFloat(self) }
}
