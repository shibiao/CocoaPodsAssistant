//
//  NSString+Name.h
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/24.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Name)

/**
 去掉扩展返回文件名

 @return 返回文件名
 */
-(NSString *)returnFileNameWithoutExtension;
@end
