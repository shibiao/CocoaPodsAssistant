//
//  SBProcess.swift
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Foundation
//SBProcess代理协议
protocol SBProcessDelegate {
    
    /// 进程执行命令成功回调
    ///
    /// - Parameter succssStr: 返回成功文字数据
    func processExecuteCommandSuccess(with succssStr: String);
    
    /// 进程执行命令失败回调
    ///
    /// - Parameter errorStr: 返回错误文字数据
    func processExecuteCommandError(with errorStr: String);
}
class SBProcess: NSObject {
    //代理
    var delegate: SBProcessDelegate?
    //当前路径
    var currentPath = String()
    //执行命令
    var command = String()
    //初始化
    init(currentPath: String, command: String) {
        super.init()
        self.currentPath = currentPath
        self.command = command
    }
    //加载进程
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
            //获取数据
            let outData = outPipe.fileHandleForReading.availableData
            outPipe.fileHandleForReading.readInBackgroundAndNotify()
            let errorData = errorPipe.fileHandleForReading.availableData
            errorPipe.fileHandleForReading.readInBackgroundAndNotify()
            let outStr = String(data: outData, encoding: String.Encoding.utf8)
            let errorStr = String(data: errorData, encoding: String.Encoding.utf8)
            if let str = errorStr {
                DispatchQueue.main.async {
                    //错误情况下代理传值，经过错误不代表执行结果一定有错误
                    self.delegate?.processExecuteCommandError(with: str)
                }
            }
            if let str = outStr {
                DispatchQueue.main.async {
                    //成功情况下代理传值
                    self.delegate?.processExecuteCommandSuccess(with: str)
                }
            }
            
            

        }
    }
}




//            NotificationCenter.default.addObserver(self, selector: #selector(self.readCompeted(_:)), name: NSNotification.Name.NSFileHandleConnectionAccepted, object: outPipe.fileHandleForReading)
