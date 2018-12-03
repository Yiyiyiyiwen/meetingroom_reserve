//
//  SignInVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/3.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "SignInVC.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface SignInVC ()

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
    NSLog(@"下一步");
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
@end
