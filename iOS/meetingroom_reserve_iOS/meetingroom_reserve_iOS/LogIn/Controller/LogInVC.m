//
//  LogInVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/1.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "LogInVC.h"
#import "UIImage+XG.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface LogInVC ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UISetting];
}

- (void) UISetting{
    //背景图片
    UIImage *backgroundImage = [UIImage imageNamed:@"backgroundImage"];
    self.backgroundView.layer.contents = (id)backgroundImage.CGImage;
    //头像
    UIImageView *headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.1, SCREEN_WIDTH*0.15, SCREEN_WIDTH*0.15)];
    UIImage_XG * headImg = [UIImage_XG imageWithIconName:@"headImage" borderImage:@"" border:0];
    headImgView.image = headImg;
    [self.view addSubview:headImgView];
    //欢迎文字
    UILabel *welcome = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.2, SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.1)];
    welcome.text = @"Hello!\n欢迎回来";
    welcome.numberOfLines = 0;
    welcome.textAlignment = NSTextAlignmentLeft;
    welcome.font = [UIFont systemFontOfSize:25];
    welcome.textColor = [UIColor whiteColor];
    [self.view addSubview:welcome];
    //手机号输入
    UILabel *tel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.3, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.1)];
    tel.textColor = [UIColor whiteColor];
    tel.text = @"手机号码";
    tel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:tel];
    UIView *telNumView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.35, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.07)];
    telNumView.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:142.0/255.0 blue:153.0/255.0 alpha:0.6];
    telNumView.layer.borderWidth = 1;
    telNumView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:telNumView];
    UILabel *regionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, telNumView.frame.size.width*0.2, telNumView.frame.size.height)];
    regionLabel.textColor = [UIColor whiteColor];
    regionLabel.text = @"+86";
    regionLabel.textAlignment = NSTextAlignmentCenter;
    [telNumView addSubview:regionLabel];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(telNumView.frame.size.width*0.2, telNumView.frame.size.height*0.2, 1, telNumView.frame.size.height*0.6)];
    line.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:93.0/255.0 blue:93.0/255.0 alpha:1.0];
    [telNumView addSubview:line];
    //电话号码输入框
    UITextField *telNumTextfield = [[UITextField alloc]initWithFrame:CGRectMake(telNumView.frame.size.width*0.25, 0, telNumView.frame.size.width*0.75, telNumView.frame.size.height)];
    telNumTextfield.tag = 1;
    telNumTextfield.keyboardType = UIKeyboardTypeNumberPad;
    telNumTextfield.textColor = [UIColor whiteColor];
    telNumTextfield.tintColor = [UIColor whiteColor];
    [telNumTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    telNumTextfield.placeholder = @"请输入手机号码";
    telNumTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [telNumView addSubview:telNumTextfield];
    //密码
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.42, SCREEN_WIDTH*0.1, SCREEN_WIDTH*0.1)];
    pwdLabel.textColor = [UIColor whiteColor];
    pwdLabel.text = @"密码";
    pwdLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:pwdLabel];
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.47, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.07)];
    pwdView.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:142.0/255.0 blue:153.0/255.0 alpha:0.6];
    pwdView.layer.borderWidth = 1;
    pwdView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:pwdView];
    //密码输入框
    UITextField *pwdTextfield = [[UITextField alloc]initWithFrame:CGRectMake(pwdView.frame.size.width*0.05, 0, pwdView.frame.size.width*0.9, pwdView.frame.size.height)];
    pwdTextfield.textColor = [UIColor whiteColor];
    pwdTextfield.tintColor = [UIColor whiteColor];
    pwdTextfield.keyboardType = UIKeyboardTypeAlphabet;
    pwdTextfield.placeholder = @"请输入密码";
    pwdTextfield.secureTextEntry = YES;
    pwdTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [pwdView addSubview:pwdTextfield];
    //登录按钮
    UIView *loginView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.6, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.07)];
    loginView.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:142.0/255.0 blue:153.0/255.0 alpha:0.6];
    loginView.layer.borderWidth = 1;
    loginView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:loginView];
    UITapGestureRecognizer *loginGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login)];
    [loginView addGestureRecognizer:loginGR];
    UILabel *loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, loginView.frame.size.width, loginView.frame.size.height)];
    loginLabel.text = @"登录";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.adjustsFontSizeToFitWidth = YES;
    loginLabel.textAlignment = NSTextAlignmentCenter;
    [loginView addSubview:loginLabel];
    //忘记密码
    UIButton *forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwd.frame = CGRectMake(SCREEN_WIDTH*0.1, SCREEN_HEIGHT*0.7, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.1);
    [forgetPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPwd.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetPwd addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwd];
    //新用户注册
    UIButton *signinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signinBtn.frame = CGRectMake(SCREEN_WIDTH*0.7, SCREEN_HEIGHT*0.03, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.1);
    [signinBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [signinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [signinBtn addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signinBtn];
}

//新用户注册
- (void) signin{
    NSLog(@"新用户注册");
}

//忘记密码
- (void) forget{
    NSLog(@"忘记密码");
}

//登录
- (void) login{
    NSLog(@"登录");
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
