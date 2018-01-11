//
//  Utility+Verify.swift
//  Utility
//
//  Created by 涂育旺 on 2018/1/2.
//  Copyright © 2018年 MYXG. All rights reserved.
//

import UIKit

/// 校验
extension Utility where Base: VerifyCompatible{
    
    public var isPhone: Bool {
        return verify(for: .isPhone(.china))
    }
    
    public var isMobile: Bool {
        return verify(for: .isPhone(.chinaMobile))
    }
    
    public var isTelecom: Bool {
        return verify(for: .isPhone(.chinaTelecom))
    }
    
    public var isUnicom: Bool {
        return verify(for: .isPhone(.chinaUnicom))
    }
    
    public var isEmail: Bool {
        return verify(for: .isEmail)
    }
    
    public var isName: Bool {
        return verify(for: .isName)
    }
    
    public var isIDCard: Bool {
        return verify(for: .isIDCard)
    }
    
    public var isPassword: Bool {
        return verify(for: .isPassword)
    }
    
}

enum PhoneType {
    case china
    case chinaMobile
    case chinaTelecom
    case chinaUnicom
}

enum VerifyType {
    case isPhone(PhoneType)
    case isEmail
    case isName
    case isIDCard
    case isPassword
    
    var regular: String {
        switch self {
        case .isPhone(let type):
            switch type {
            case .china: return "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$"
            case .chinaMobile: return "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
            case .chinaTelecom: return "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"
            case .chinaUnicom: return "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
            }
        case .isEmail: return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        case .isName: return "^[A-Za-z0-9]{6,20}+$"
        case .isIDCard: return "^(\\d{14}|\\d{17})(\\d|[xX])$"
        case .isPassword: return "^[a-zA-Z0-9]{6,20}+$"
        }
    }
}
extension Utility {
    
    fileprivate func verify(for type: VerifyType) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", type.regular).evaluate(with: base)
    }
}

public protocol VerifyCompatible {}
extension String: VerifyCompatible {}
