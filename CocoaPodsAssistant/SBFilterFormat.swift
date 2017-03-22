//
//  SBFilterFormat.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Foundation

class SBFilterFormat: NSObject {
    func filterFormat(by array: Array<Any>) -> String {
        let filterArr = array.filter { String(describing: $0).contains(".xcodeproj")
        }
        if filterArr.count > 0 {
            return filterArr.first as! String
        }
        return ""
    }
}
