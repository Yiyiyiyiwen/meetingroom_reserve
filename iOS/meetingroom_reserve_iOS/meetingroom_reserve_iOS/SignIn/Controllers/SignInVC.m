//
//  SignInVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/3.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "SignInVC.h"
#import "SetPasswordVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface SignInVC ()
@property (nonatomic, strong) UITextField* telText;
@end

@implementation SignInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UISetting];
}

//UI布局
- (void) UISetting{
    //导航栏标题
    self.navigationItem.title = @"新用户注册";
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [backBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:136.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBarBtn;
    //手机号码
    UILabel *tel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.25, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.1)];
    tel.text = @"手机号码";
    tel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:tel];
    //手机号输入
    UIView *telView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.35, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13)];
    telView.layer.masksToBounds = YES;
    telView.layer.cornerRadius = 5.0;
    telView.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:142.0/255.0 blue:153.0/255.0 alpha:0.6];
    [self.view addSubview:telView];
    UILabel *regionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, telView.frame.size.width*0.2, telView.frame.size.height)];
    regionLabel.textColor = [UIColor blackColor];
    regionLabel.text = @"+86";
    regionLabel.textAlignment = NSTextAlignmentCenter;
    [telView addSubview:regionLabel];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(telView.frame.size.width*0.2, telView.frame.size.height*0.2, 1, telView.frame.size.height*0.6)];
    line.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:93.0/255.0 blue:93.0/255.0 alpha:1.0];
    [telView addSubview:line];
    //电话号码输入框
    UITextField *telNumTextfield = [[UITextField alloc]initWithFrame:CGRectMake(telView.frame.size.width*0.25, 0, telView.frame.size.width*0.75, telView.frame.size.height)];
    self.telText = telNumTextfield;
    telNumTextfield.tag = 1;
    telNumTextfield.keyboardType = UIKeyboardTypeNumberPad;
    telNumTextfield.textColor = [UIColor blackColor];
    telNumTextfield.tintColor = [UIColor blackColor];
    [telNumTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    telNumTextfield.placeholder = @"请输入手机号码";
    telNumTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [telView addSubview:telNumTextfield];
    //下一步按钮
    UIButton *nextStep = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextStep.layer setMasksToBounds:YES];
    [nextStep.layer setCornerRadius:5.0];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStep setBackgroundColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]];
    nextStep.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.48, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13);
    [nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
}

- (void) next{
    if ([self valiMobile:self.telText.text]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SetPasswordVC *vc = [sb instantiateViewControllerWithIdentifier:@"SetPassword"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self showError:@"手机号码有误，请重新输入!"];
    }
}

//返回
- (void) back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//电话键盘监听
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length >= 11) {
        textField.text = [textField.text substringToIndex:11];
    }
}

//键盘弹回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//手机号码格式判断
- (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11){
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

// 提示错误信息
- (void)showError:(NSString *)errorMsg {
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}
@end
