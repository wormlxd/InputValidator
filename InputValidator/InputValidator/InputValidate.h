//
//  InputValidate.h
//  IndustryEducation
//
//  Created by linxiaodong on 15-2-4.
//  Copyright (c) 2015年 com.nd.hy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^InputValidBlock)(void);

enum {
    InputValidatorTypeNone = -1,
    InputValidatorTypePassword,
    InputValidatorTypeAccount,
};

typedef NSInteger InputValidatorType;


typedef enum
{
    RegisterUnknow = -1,
    RegisterMobile = 0,
    RegisterEmail,
    RegisterUserName,
    RegistIDCard,
}RegisterType;


@interface InputValidate : NSObject

- (BOOL)validateInput:(NSString *)content;
- (void)validateInput:(NSString *)content WithSuccessBlock:(InputValidBlock)successBlock andFailBlock:(InputValidBlock)failBlock;
- (NSString *)validPrompt;
- (BOOL)secure;
- (BOOL)isOnlyAscii;
@end

@interface InputValidatorFactory : NSObject
+(InputValidate* )validatorForType:(InputValidatorType)type;
@end

/*
    支持，手机，邮箱，身份证的正则过滤
 */
@interface InputValidatorAccount : InputValidate
@property (nonatomic ,assign) RegisterType registerType;
@end
/*
    密码规则，6-12位，不包含特殊字符
 */
@interface InputValidatorPassword : InputValidate
@end