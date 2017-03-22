//
//  AppDelegate.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/21.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var status = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    var popover = NSPopover()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        status.target = self
        status.action = #selector(showPopover)
        status.image = #imageLiteral(resourceName: "cocoa")
        
    }
    func showPopover() {
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

