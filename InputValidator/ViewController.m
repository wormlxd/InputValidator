//
//  ViewController.m
//  InputValidator
//
//  Created by linxiaodong on 15/11/11.
//  Copyright © 2015年 linxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "InputValidate.h"

@interface ViewController ()<UITextFieldDelegate>
{
    IBOutlet UITextField *_inputUser;
    IBOutlet UITextField *_inputPassword;
}
@end

@implementation ViewController

- (IBAction)onSubmitpressed:(id)sender
{
    [_inputUser resignFirstResponder];
    [_inputPassword resignFirstResponder];
    
    InputValidatorAccount *validateUser = (InputValidatorAccount *)[InputValidatorFactory validatorForType:InputValidatorTypeAccount];
    validateUser.registerType = RegistIDCard;
    [validateUser validateInput:_inputUser.text WithSuccessBlock:^(void){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入账号合法" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } andFailBlock:^(void){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[validateUser validPrompt] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _inputPassword.secureTextEntry = YES;
    _inputUser.delegate = self;
    _inputPassword.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder];//查一下resign这个单词的意思就明白这个方法了
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == _inputUser) {
        InputValidatorAccount *validate = (InputValidatorAccount *)[InputValidatorFactory validatorForType:InputValidatorTypeAccount];
        validate.registerType = RegisterMobile;
        [validate validateInput:textField.text WithSuccessBlock:^(void){
            NSLog(@"输入账号合法");
        } andFailBlock:^(void){
            NSLog(@"%@",[validate validPrompt]);
        }];
        [textField resignFirstResponder];
    }
    if (textField == _inputPassword) {
        InputValidatorPassword *validate = (InputValidatorPassword *)[InputValidatorFactory validatorForType:InputValidatorTypePassword];
        [validate validateInput:textField.text WithSuccessBlock:^{
            NSLog(@"输入密码合法");
        } andFailBlock:^{
            NSLog(@"%@",[validate validPrompt]);
        }];
        [textField resignFirstResponder];
    }
    return YES;
}

@end
