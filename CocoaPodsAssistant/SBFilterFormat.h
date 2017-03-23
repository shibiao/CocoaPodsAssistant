//
//  SBFilterFormat.h
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/22.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBFilterFormat : NSObject
//文件名
@property (nonatomic,copy) NSString *name;

/**
 过滤拖拽文件进box的路径

 @param array 拖拽进的文件路径（可能同时拖拽多个文件）
 @return 返回文件所在文件夹路径
 */
-(NSString *)filterFormatByArray:(NSArray *)array;
@end
