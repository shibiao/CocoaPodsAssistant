//
//  SBBox.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa

class SBBox: NSBox {

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
        let pboardArray = sender.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as! Array<Any>
        let filterArray = SBFilterFormat()
        let filteredPath = filterArray.filterFormat(by: pboardArray)
        if !filteredPath.isEmpty {
            Swift.print(filteredPath)
            return true
        }
        return false
    }
}
