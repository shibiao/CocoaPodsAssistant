//
//  SBBox.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa
protocol SBBoxDelegate {
    func sbBoxGetFile(for path:String, with name: String);
}
class SBBox: NSBox {
    var delegate: SBBoxDelegate?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.register(forDraggedTypes: [kUTTypeURL as String])
        
    }
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return NSDragOperation.copy
    }
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation  {
        return NSDragOperation.copy
    }
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pboardArray = sender.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as! Array<String>
        let filterFormat = SBFilterFormat()
        let filteredPath = filterFormat.filterFormat(by: pboardArray)
        if !(filteredPath?.isEmpty)! {
            Swift.print("filteredPath:" + "\(filteredPath)")
            delegate?.sbBoxGetFile(for: filteredPath! ,with: filterFormat.name)
            return true
        }
        return false
    }
}
