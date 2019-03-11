//
//  SetUserNameVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/3/11.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "SetUserNameVC.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface SetUserNameVC ()
@property (nonatomic, strong) UITextField* telText;
@end

@implementation SetUserNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UISetting];
}

//UI布局
- (void) UISetting{
    //导航栏标题
    self.navigationItem.title = @"设置用户名";
    //用户名
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.25, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.1)];
    name.text = @"用户名";
    name.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:name];
    //用户名输入
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.35, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13)];
    nameView.layer.masksToBounds = YES;
    nameView.layer.cornerRadius = 5.0;
    nameView.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:142.0/255.0 blue:153.0/255.0 alpha:0.6];
    [self.view addSubview:nameView];
    //用户名输入框
    UITextField *nameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, nameView.frame.size.width-10, nameView.frame.size.height)];
    self.telText = nameTextfield;
    nameTextfield.tag = 1;
    nameTextfield.keyboardType = UIKeyboardTypeDefault;
    nameTextfield.textColor = [UIColor blackColor];
    nameTextfield.tintColor = [UIColor blackColor];
    [nameTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    nameTextfield.placeholder = @"请输入用户名";
    nameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameView addSubview:nameTextfield];
    //完成按钮
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [finish.layer setMasksToBounds:YES];
    [finish.layer setCornerRadius:5.0];
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finish setBackgroundColor:[UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0]];
    finish.frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.48, SCREEN_WIDTH*0.9, SCREEN_WIDTH*0.13);
    [finish addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finish];
}

- (void) finish{
    [self.signInRequestDic setValue:self.telText.text forKey:@"name"];
    NSString *phone = [self.signInRequestDic objectForKey:@"phone"];
    NSString *password = [self.signInRequestDic objectForKey:@"password"];
    NSString *msg = [self.signInRequestDic objectForKey:@"msg"];
    NSString *name = [self.signInRequestDic objectForKey:@"name"];
    NSDictionary *parameters = @{
                                 @"phone":phone,
                                 @"password":password,
                                 @"msg":msg,
                                 @"name":name
                                 };
    NSLog(@"%@",parameters);
    NSString *urlString = @"http://fc2018.bwg.moyinzi.top/api/user/register";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求
    [managers GET:urlString parameters:parameters headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功，服务器返回的信息%@",responseObject);
        [SVProgressHUD dismiss];
        NSString *msg = [responseObject objectForKey:@"msg"];
        if ([msg isEqualToString:@"SUCCESS"]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [SVProgressHUD dismissWithDelay:1.0];
        }else if ([msg isEqualToString:@"USER_HAS_EXIST"]){
            [SVProgressHUD showErrorWithStatus:@"用户已存在"];
            [SVProgressHUD dismissWithDelay:1.0];
        }else{
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
        [NSThread sleepForTimeInterval:1.0];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD dismissWithDelay:1.0];
    }];
}


//键盘监听
- (void)textFieldDidChange:(UITextField *)textField{
}

//键盘弹回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
