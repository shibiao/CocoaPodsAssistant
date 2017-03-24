//
//  NSString+Name.m
//  CocoaPodsAssistant
//
//  Created by sycf_ios on 2017/3/24.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "NSString+Name.h"

@implementation NSString (Name)
-(NSString *)returnFileNameWithoutExtension{
    return self.lastPathComponent.stringByDeletingPathExtension;
}
@end
