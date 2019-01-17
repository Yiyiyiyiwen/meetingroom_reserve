//
//  VerificationCodeVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/17.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "VerificationCodeVC.h"
#import "VerificationCodeView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface VerificationCodeVC ()

@end

@implementation VerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationItem setHidesBackButton:YES];
    //请输入验证码
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.2, SCREEN_WIDTH*0.4, SCREEN_WIDTH*0.1)];
    remindLabel.text = @"请输入验证码";
    remindLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:remindLabel];
    //验证码已发送到手机
    NSString *telCheckStr1 = @"验证码已发送至手机:+86 ";
    NSString *telCheckStr2 = self.telNum;
    NSString *telCheckStr = [telCheckStr1 stringByAppendingString:telCheckStr2];
    UILabel *telCheckLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1, SCREEN_WIDTH*0.7, SCREEN_WIDTH*0.06)];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:telCheckStr];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]
                          range:NSMakeRange(10, 15)];
    telCheckLabel.attributedText = AttributedStr;
    telCheckLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:telCheckLabel];
    //验证码输入
    VerificationCodeView *mainView = [[VerificationCodeView alloc]initWithCount:4 margin:SCREEN_WIDTH*0.2/3.0];
    mainView.frame = CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1+SCREEN_WIDTH*0.06, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.2);
    [self.view addSubview:mainView];
    //重新发送验证码
    UIButton *retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [retryBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
    [retryBtn setTitleColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    retryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    retryBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    retryBtn.frame = CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1+SCREEN_WIDTH*0.06+SCREEN_HEIGHT*0.2+30, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.06);
    [retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retryBtn];
    //下一步按钮
    UIButton *nextStep = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextStep.layer setMasksToBounds:YES];
    [nextStep.layer setCornerRadius:5.0];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStep setBackgroundColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]];
    nextStep.frame = CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.6, SCREEN_WIDTH*0.8, SCREEN_WIDTH*0.13);
    [nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
}

//重发验证码
- (void) retry{
    NSLog(@"retry");
}

//下一步
- (void) next{
    NSLog(@"next");
}

//键盘弹回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
