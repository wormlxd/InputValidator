//
//  InputValidate.m
//  IndustryEducation
//
//  Created by linxiaodong on 15-2-4.
//  Copyright (c) 2015年 com.nd.hy. All rights reserved.
//

#import "InputValidate.h"
#import "NSString+PDRegex.h"
#import "NSString+Extension.h"
@implementation InputValidatorFactory
+(InputValidate* )validatorForType:(InputValidatorType)type {
    switch (type) {
        case InputValidatorTypePassword:
            return [[InputValidatorPassword alloc] init];
        case InputValidatorTypeAccount:
            return [[InputValidatorAccount alloc]init];
        default:
            return [[InputValidate alloc] init];
    }
    return nil;
    
}
@end

@implementation InputValidate
- (BOOL)validateInput:(NSString *)content
{
    return content && ![content isAllSpace];
}
- (void)validateInput:(NSString *)content WithSuccessBlock:(InputValidBlock)successBlock andFailBlock:(InputValidBlock)failBlock
{
    if ([self validateInput:content]) {
        successBlock();
    }else {
        failBlock();
    }
}
- (BOOL)validateAbleInput:(NSString *)content
{
    return content && ![content isAllSpace];
}

- (NSString *)validPrompt
{
    return nil;
}

- (BOOL)secure {
    return NO;
}

- (BOOL)isOnlyAscii {
    return NO;
}
@end



@implementation InputValidatorAccount
- (BOOL)validateInput:(NSString *)content
{
    NSString *regexString = [NSString getRegexStringByType:self.registerType];
    
    BOOL isMatchRegex = [content matchesPatternRegexPattern:regexString];
    
    return content && ![content isAllSpace] && isMatchRegex;
}

- (BOOL)validateAbleInput:(NSString *)content
{
    return content.length <= 20 ;
}

- (NSString *)validPrompt
{
    switch (self.registerType) {
        case RegisterEmail:
            return @"邮箱格式不对";
        case RegisterMobile:
            return @"手机号码格式不对";
        case RegisterUserName:
            return @"用户名格式不对，请输入以字母开头的6~20个字符作为用户名，可使用小写字母、数字、下划线和小数点";
        case RegistIDCard:
            return @"身份证输入格式不对";
        default:
            break;
    }
    return  nil;
}

@end


@implementation InputValidatorPassword


- (BOOL)validateInput:(NSString *)content
{
    NSCharacterSet* set = [NSCharacterSet characterSetWithCharactersInString:@" ！@#￥%……&*（）[]{};:<>,。?~`"];
    NSRange range = [content rangeOfCharacterFromSet:set];
    
    return content && ![content isAllSpace] && (range.location == NSNotFound);
}

- (BOOL)validateAbleInput:(NSString *)content
{
    if (content.length <= 12 && content.length >=6) {
        return YES;
    }
    return NO;
}


- (NSString *)validPrompt
{
    return @"密码输入不能有空格等非法字符";
}

- (BOOL)secure {
    return YES;
}

- (BOOL)isOnlyAscii {
    return YES;
}

@end