//
//  VerificationCodeVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/17.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "VerificationCodeVC.h"
#import "VerificationCodeView.h"
#import "SetPasswordVC.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface VerificationCodeVC ()
@property (nonatomic, strong) NSString* vCode;//服务器返回的验证码
@property (nonatomic, strong) VerificationCodeView* mainView;
@end

@implementation VerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"验证码";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationItem setHidesBackButton:YES];
    //请输入验证码
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.2, SCREEN_WIDTH*0.4, SCREEN_WIDTH*0.1)];
    remindLabel.text = @"请输入验证码";
    remindLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:remindLabel];
    //验证码已发送到手机
    NSString *telCheckStr1 = @"验证码已发送至手机:+86 ";
    NSString *telCheckStr2 = self.telNum;
    NSString *telCheckStr = [telCheckStr1 stringByAppendingString:telCheckStr2];
    UILabel *telCheckLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1, SCREEN_WIDTH*0.7, SCREEN_WIDTH*0.06)];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:telCheckStr];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]
                          range:NSMakeRange(10, 15)];
    telCheckLabel.attributedText = AttributedStr;
    telCheckLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:telCheckLabel];
    //验证码输入
    self.mainView = [[VerificationCodeView alloc]initWithCount:6 margin:SCREEN_WIDTH*0.2/3.0];
    self.mainView.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1+SCREEN_WIDTH*0.06, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.2);
    [self.view addSubview:self.mainView];
    //重新发送验证码
    UIButton *retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [retryBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
    [retryBtn setTitleColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    retryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    retryBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    retryBtn.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1+SCREEN_WIDTH*0.06+SCREEN_HEIGHT*0.2+30, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.06);
    [retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retryBtn];
    //下一步按钮
    UIButton *nextStep = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextStep.layer setMasksToBounds:YES];
    [nextStep.layer setCornerRadius:5.0];
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStep setBackgroundColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]];
    nextStep.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.6, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13);
    [nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStep];
    //请求的url
    NSString *urlString = @"http://fc2018.bwg.moyinzi.top/api/public/see_msg/";
    NSString *totalString = [urlString stringByAppendingString:self.telNum];
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求
    [managers GET:totalString parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功，服务器返回的信息%@",responseObject);
        NSString *data = [responseObject objectForKey:@"data"];
        self.vCode = data;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
    }];
    
//    NSLog(@"%@",self.signInRequestDic);
}

//重发验证码
- (void) retry{
    [SVProgressHUD show];
    NSString *telNumber = self.telNum;
    //请求的参数
    NSDictionary *parameters = @{
                                 @"phone":telNumber
                                 };
    //请求的url
    NSString *urlString = @"http://fc2018.bwg.moyinzi.top/api/public/send_msg";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求
    [managers GET:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功，服务器返回的信息%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
    //请求的url
    NSString *url = @"http://fc2018.bwg.moyinzi.top/api/public/see_msg/";
    NSString *totalString = [url stringByAppendingString:self.telNum];
    //请求的managers
    AFHTTPSessionManager *ms = [AFHTTPSessionManager manager];
    //请求
    [ms GET:totalString parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功，服务器返回的信息%@",responseObject);
        NSString *data = [responseObject objectForKey:@"data"];
        self.vCode = data;
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"验证码发送成功"];
        [SVProgressHUD dismissWithDelay:1.0];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
    
}

//下一步
- (void) next{
    if ([self.mainView.code isEqualToString:self.vCode]) {
        [self.signInRequestDic setValue:self.vCode forKey:@"msg"];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SetPasswordVC *vc = [sb instantiateViewControllerWithIdentifier:@"SetPassword"];
        vc.signInRequestDic = self.signInRequestDic;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}

//键盘弹回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
