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
        if let statusBtn = status.button {
            statusBtn.target = self
            statusBtn.action = #selector(showOrHidePopover(_:))
            statusBtn.image = #imageLiteral(resourceName: "cocoa")
        }
        let vc = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "ViewController") as! ViewController
        popover.contentViewController = vc
        popoverShow()
    }
    func showOrHidePopover(_ sender: NSStatusBarButton) {
        if popover.isShown {
            popover.performClose(sender)
        }else{
            popoverShow()
        }
    }
    func popoverShow() {
        popover.behavior = .semitransient
        popover.show(relativeTo: (status.button?.frame)!, of: status.button!, preferredEdge: .minY)
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

