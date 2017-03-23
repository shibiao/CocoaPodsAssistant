//
//  SBFilterFormat.m
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "SBFilterFormat.h"

@implementation SBFilterFormat
/**
 class SBFilterFormat: NSObject {
 func filterFormat(by array: Array<Any>) -> String {
 let filterArr = array.filter { String(describing: $0).contains(".xcodeproj")
 }
 if filterArr.count > 0 {
 var usefulStr = filterArr.first as! String
 var tmpArr = usefulStr.components(separatedBy: "/")
 usefulStr = tmpArr.remove(at: tmpArr.count-2)
 
 return usefulStr
 }
 return ""
 }
 }
 */
-(NSString *)filterFormatByArray:(NSArray *)array {
    NSString *resultStr;
    for (NSString *str in array) {
        if ([str.pathExtension isEqualToString:@"xcodeproj"]) {
            self.name = str.lastPathComponent;
            resultStr = str.stringByDeletingLastPathComponent;
            return resultStr;
        }
    }
    return nil;
}

@end
