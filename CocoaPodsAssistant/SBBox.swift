//
//  SBBox.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa
//SBBox代理
protocol SBBoxDelegate {
    /// 获取拖拽进box里文件的文件夹路径和文件名
    ///
    /// - Parameters:
    ///   - path: 文件夹路径
    ///   - name: 文件名
    func sbBoxGetFile(for path:String, with name: String);
}
class SBBox: NSBox {
    var delegate: SBBoxDelegate?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        //注册所有文件类型
        self.register(forDraggedTypes: [kUTTypeURL as String])
        
    }
    //MARK drag代理方法
//    drag文件进入
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return NSDragOperation.copy
    }
//    drag文件的操作
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pboardArray = sender.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as! Array<String>
        let filterFormat = SBFilterFormat()
        let filteredPath = filterFormat.filterFormat(by: pboardArray)
        if filteredPath != nil {
            delegate?.sbBoxGetFile(for: filteredPath! ,with: filterFormat.name)
            return true
        }
        return false
    }
}
