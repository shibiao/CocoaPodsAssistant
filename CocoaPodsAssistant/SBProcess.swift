//
//  SBProcess.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Foundation
protocol SBProcessDelegate {
    func processExecuteCommandSuccess(with succssStr: NSString);
    func processExecuteCommandError(with errorStr: NSString);
}
class SBProcess: NSObject {
    var delegate: SBProcessDelegate?
    var currentPath = String()
    var command = String()
     init(currentPath: String, command: String) {
        super.init()
        self.currentPath = currentPath
        self.command = command
    }
    func launchProcess() {
        let process = Process()
        
        let args = ["-l","-c",command]
        process.arguments = args as [String]?
        process.currentDirectoryPath = currentPath as String
        process.launchPath = "/bin/bash"
        
        let outPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outPipe
        process.standardError = errorPipe
        
        process.launch()
        process.waitUntilExit()

        DispatchQueue.global().async {
            let outData = outPipe.fileHandleForReading.availableData
//            NotificationCenter.default.addObserver(self, selector: #selector(self.readCompeted(_:)), name: NSNotification.Name.NSFileHandleConnectionAccepted, object: outPipe.fileHandleForReading)
            outPipe.fileHandleForReading.readInBackgroundAndNotify()
            let errorData = errorPipe.fileHandleForReading.availableData
            errorPipe.fileHandleForReading.readInBackgroundAndNotify()
            let outStr = String(data: outData, encoding: String.Encoding.utf8)
            let errorStr = String(data: errorData, encoding: String.Encoding.utf8)
            if let str = errorStr {
                DispatchQueue.main.async {
                    self.delegate?.processExecuteCommandError(with: str as NSString)
                }
            }
            if let str = outStr {
                DispatchQueue.main.async {
                    self.delegate?.processExecuteCommandSuccess(with: str as NSString)
                }
            }
            
            

        }
    }
}
