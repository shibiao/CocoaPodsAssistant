//
//  ViewController.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/21.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {


    @IBOutlet weak var inputTextField: NSTextField!
    @IBOutlet var subView: NSView!
    var subWindow: NSWindow!
    
    @IBOutlet var textField: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.backgroundColor = NSColor.clear
    }

    @IBAction func run(_ sender: Any) {
        if !(textField.string?.isEmpty)! {
            textField.string = ""
        }
        if subWindow != nil {
            view.window?.removeChildWindow(subWindow)
            subWindow = nil
        }
        let process = SBProcess(currentPath: "~/Desktop/TEST/MACPlayer/AVPla", command: inputTextField.stringValue)
        print(inputTextField.stringValue)
        process.delegate = self
        process.launchProcess()
        
//        print(Thread.callStackSymbols)
        
    }
//    func readCompeted(_ notification: NSNotification) {
//        print("Read Data:\(notification.userInfo?.index(forKey: NSFileHandleNotificationDataItem))")
//    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}
extension ViewController: SBProcessDelegate {
    func processExecuteCommandSuccess(with succssStr: NSString) {
        let frame = self.view.window?.frame
        self.subWindow = NSWindow(contentRect: NSRect(x: (frame?.origin.x)!, y: (frame?.origin.y)!-100, width: (frame?.size.width)!, height: 100), styleMask: [.unifiedTitleAndToolbar], backing: NSBackingStoreType.nonretained, defer: true, screen: NSScreen.main())
        self.subWindow.contentView = self.subView
        self.view.window?.addChildWindow(self.subWindow, ordered: .below)
        
        self.textField.string = succssStr as String
    }
    func processExecuteCommandError(with errorStr: NSString) {
        self.textField.string = errorStr as String
    }
}
