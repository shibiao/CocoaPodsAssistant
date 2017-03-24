//
//  SBFilterFormat.m
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "SBFilterFormat.h"

@implementation SBFilterFormat

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
