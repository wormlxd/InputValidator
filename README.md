# InputValidator
支持各种输入验证
继承InputValidator

支持，手机号，邮箱，身份证等正则表达式过滤的账号输入



	-(BOOL)validateInput:(NSString *)content
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

支持密码的简单过滤规则

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

支持block回调

	  [validate validateInput:textField.text WithSuccessBlock:^(void){
	      NSLog(@"输入账号合法");
	  } andFailBlock:^(void){
	      NSLog(@"%@",[validate validPrompt]);
	  }];