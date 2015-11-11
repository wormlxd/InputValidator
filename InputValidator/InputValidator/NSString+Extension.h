//
//  NSString+Extension.h
//  RTMPPlayerTest
//
//  Created by linxiaodong on 14-7-14.
//  Copyright (c) 2014年 linxiaodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputValidate.h"

@interface NSString (Extension)
+ (NSString *)getRegexStringByType:(RegisterType)type;
- (BOOL)isAllSpace;
@end