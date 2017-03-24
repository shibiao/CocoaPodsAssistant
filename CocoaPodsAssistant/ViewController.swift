//
//  ViewController.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/21.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa
//分三步走
enum StepEnumeration {
    case First
    case Second
    case Third
}
class ViewController: NSViewController {

    var step = StepEnumeration.First
    //podfile编辑TextView
    @IBOutlet var podfileTextView: NSTextView!
    //box中间显示的label，也是文件名
    @IBOutlet weak var boxLabel: NSTextField!
    //box
    @IBOutlet weak var box: SBBox!
    //弹出的子视图
    @IBOutlet var subView: NSView!
    //弹出子视图的window
    var subWindow: NSWindow!
    //文件的文件夹路径
    var path: String! = nil
    @IBOutlet var textField: NSTextView!
    //执行命令
    var cmd: String!{
        get {
            switch step {
            case .First:
                return "pod init"
            case .Second:
                return "pod install"
            case .Third:
                //NSString 转 String 因为returnFileNameWithoutExtension方法是增加的NSString category方法
                let tmpStr = self.boxLabel.stringValue as NSString
                let str = tmpStr.returnFileNameWithoutExtension() as String
                return "open " + self.path + "/" + str.appending(".xcworkspace")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        box.delegate = self
        self.textField.backgroundColor = NSColor.clear
    }

    @IBAction func run(_ sender: Any) {
        DispatchQueue.global().async {
            self.runProcess()
        }
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
            let process = SBProcess(currentPath: resultPath, command: cmd)
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
       firstStep(with: succssStr)
    }
    func processExecuteCommandError(with errorStr: String) {
        self.textField.string = errorStr as String
    }
    //第一步
    func firstStep(with successStr: String) {
        if step == .Third {
            let delegate = NSApp.delegate as! AppDelegate
            delegate.popover.close()
            return
        }
        let frame = self.view.window?.frame
        self.subWindow = NSWindow(contentRect: NSRect(x: (frame?.origin.x)!, y: (frame?.origin.y)!-100, width: (frame?.size.width)!, height: 100), styleMask: [.unifiedTitleAndToolbar], backing: NSBackingStoreType.nonretained, defer: true, screen: NSScreen.main())
        self.subWindow.contentView = self.subView
        self.view.window?.addChildWindow(self.subWindow, ordered: .below)
        self.textField.string = successStr as String
        if step == .First {
            step = .Second
            secondStep()
            return
        }else{
            step = .Third
            runProcess()
        }
        
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
//MARK: NSTextViewDelegate
extension ViewController:  NSTextViewDelegate {
    
    func textDidChange(_ notification: Notification) {
        wirteFileContent()
    }
    func textDidEndEditing(_ notification: Notification) {
        wirteFileContent()
    }
    //及时将修改的内容保存到文件
    func wirteFileContent() {
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1), execute: {
            guard !self.path.isEmpty else {return}
            let podfilePath = self.path.appending("/Podfile")
            if FileManager.default.fileExists(atPath: podfilePath)
            {
                    do {
                        if let str = self.podfileTextView.string {
                            try str.write(toFile: podfilePath, atomically: true, encoding: String.Encoding.utf8)
                        }
                        
                    } catch {
                    print(error)
                }
            }

        })
    }
}
//MARK: SBBoxDelegate
extension ViewController: SBBoxDelegate {
    func sbBoxGetFile(for path:String, with name: String){
        self.path = path
        boxLabel.stringValue = name
        if !boxLabel.stringValue.isEmpty {
            step = .First
            runProcess()
        }
    }
}

