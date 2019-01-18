//
//  SetPasswordVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/18.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "SetPasswordVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface SetPasswordVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UITextField *pwdText;
@end

@implementation SetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"设置密码";
    //请输入密码
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.2, SCREEN_WIDTH*0.4, SCREEN_WIDTH*0.1)];
    remindLabel.text = @"请输入密码";
    remindLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:remindLabel];
    //登录密码用于客户端登录
    NSString *check = @"登录密码用于客户端登录";
    UILabel *checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1, SCREEN_WIDTH*0.7, SCREEN_WIDTH*0.06)];
    checkLabel.text = check;
    checkLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:checkLabel];
    //密码输入框
    UIView *passwordView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.2+SCREEN_WIDTH*0.1+SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.12)];
    [self.view addSubview:passwordView];
    CGFloat pWidth = passwordView.frame.size.width;
    CGFloat pHeight = passwordView.frame.size.height;
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pWidth*0.2, SCREEN_HEIGHT*0.02)];
    pwdLabel.text = @"密码";
    pwdLabel.font = [UIFont systemFontOfSize:13];
    [passwordView addSubview:pwdLabel];
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, pHeight*0.99, pWidth, pHeight*0.01)];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [passwordView addSubview:self.line];
    self.pwdText = [[UITextField alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.04, pWidth*0.9, SCREEN_HEIGHT*0.075)];
    self.pwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdText.placeholder = @"请输入密码";
    self.pwdText.delegate = self;
    [self.pwdText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [passwordView addSubview:self.pwdText];
    UIButton *eye = [UIButton buttonWithType:UIButtonTypeCustom];
    [eye setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    eye.adjustsImageWhenHighlighted = NO;
    eye.frame = CGRectMake(pWidth*0.92, SCREEN_HEIGHT*0.062, pWidth*0.06, pWidth*0.06);
    [eye addTarget:self action:@selector(eyeTouch:) forControlEvents:UIControlEventTouchUpInside];
    [passwordView addSubview:eye];
}

- (void)eyeTouch:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) { // 按下去了就是明文
        [sender setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        NSString *tempPwdStr = self.pwdText.text;
        self.pwdText.text = @""; // 这句代码可以防止切换的时候光标偏移
        self.pwdText.secureTextEntry = NO;
        self.pwdText.text = tempPwdStr;
    } else { // 暗文
        [sender setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        NSString *tempPwdStr = self.pwdText.text;
        self.pwdText.text = @"";
        self.pwdText.secureTextEntry = YES;
        self.pwdText.text = tempPwdStr;
    }
}

//电话键盘监听
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length >= 20) {
        textField.text = [textField.text substringToIndex:20];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.line.backgroundColor = [UIColor colorWithRed:97.0/255.0 green:134.0/255.0 blue:220.0/255.0 alpha:1.0];
    return YES;
}

//密码格式判断
- (BOOL)valiPassword:(NSString *)password{
    password = [password stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (password.length > 20){
        return NO;
    }else{
        return YES;
    }
}

//键盘弹回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.view endEditing:YES];
}
@end