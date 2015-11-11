//
//  NSString+Extension.m
//  RTMPPlayerTest
//
//  Created by linxiaodong on 14-7-14.
//  Copyright (c) 2014年 linxiaodong. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)getRegexStringByType:(RegisterType)type
{
    NSString *regexString = @"";
    
    switch (type) {
        case RegisterEmail:
            regexString = @"^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$";
            break;
        case RegisterMobile:
            regexString = @"^(1)\\d{10}$";
            break;
        case RegisterUserName:
            regexString = @"^[a-z][a-z0-9_.]{5,19}$";
            break;
        case RegistIDCard:
            regexString = @"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{15}(\\d|X|x)$";
            break;
        default:
            break;
    }
    return regexString;
}

- (BOOL)isAllSpace
{
    NSInteger len = self.length;
    NSInteger index = 0;
    
    for (index = 0; index < len; index++) {
        if ([self characterAtIndex:index] != ' ') {
            break;
        }
    }
    return index >= len;
}
@end