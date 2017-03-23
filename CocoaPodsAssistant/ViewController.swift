//
//  ViewController.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/21.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa
enum StepEnumeration {
    case First
    case Second
    case Third
}
class ViewController: NSViewController {

    var step = StepEnumeration.First
    //podfile编辑TextView
    @IBOutlet var podfileTextView: NSTextView!
    //box中间显示的label
    @IBOutlet weak var boxLabel: NSTextField!
    //box
    @IBOutlet weak var box: SBBox!
    @IBOutlet weak var inputTextField: NSTextField!
    @IBOutlet var subView: NSView!
    var subWindow: NSWindow!
    var path: String! = nil
    @IBOutlet var textField: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        box.delegate = self
        self.textField.backgroundColor = NSColor.clear
    }

    @IBAction func run(_ sender: Any) {
        runProcess()
    }
    //运行进程
    func runProcess() {
        if !(textField.string?.isEmpty)! {
            textField.string = ""
        }
        
        if subWindow != nil {
            view.window?.removeChildWindow(subWindow)
            subWindow = nil
        }
        if let resultPath = path {
            let process = SBProcess(currentPath: resultPath, command: inputTextField.stringValue)
            process.delegate = self
            process.launchProcess()
        }
        //        print(Thread.callStackSymbols)
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}
//MARK: SBProcessDelegate
extension ViewController: SBProcessDelegate {
    func processExecuteCommandSuccess(with succssStr: String) {
        switch step {
        case .First:
           firstStep(with: succssStr)
            break
        case .Second:
            
            break
        case .Third:
            break
        }
        
    }
    func processExecuteCommandError(with errorStr: String) {
        self.textField.string = errorStr as String
    }
    //第一步
    func firstStep(with successStr: String) {
        let frame = self.view.window?.frame
        self.subWindow = NSWindow(contentRect: NSRect(x: (frame?.origin.x)!, y: (frame?.origin.y)!-100, width: (frame?.size.width)!, height: 100), styleMask: [.unifiedTitleAndToolbar], backing: NSBackingStoreType.nonretained, defer: true, screen: NSScreen.main())
        self.subWindow.contentView = self.subView
        self.view.window?.addChildWindow(self.subWindow, ordered: .below)
        self.textField.string = successStr as String
        step = .Second
    }
    //第二步
    func secondStep() {
        let fileHandle = FileHandle(forReadingAtPath: path.appending("/Podfile"))
        if let fileData = fileHandle?.availableData {
            podfileTextView.string = String(data: fileData, encoding: String.Encoding.utf8)
        }
    }
    override func mouseDown(with event: NSEvent) {
        podfileTextView.acceptsFirstMouse(for: event)
    }

}
extension ViewController: NSTextStorageDelegate, NSTextViewDelegate {
    
    func textDidChange(_ notification: Notification) {
        
    }
    func textDidEndEditing(_ notification: Notification) {
        
    }
    func textDidBeginEditing(_ notification: Notification) {
        
    }

}

extension ViewController: SBBoxDelegate {
    func sbBoxGetFile(for path:String, with name: String){
        self.path = path
        boxLabel.stringValue = name
        if !boxLabel.stringValue.isEmpty {
            step = .First
        }
    }
}
