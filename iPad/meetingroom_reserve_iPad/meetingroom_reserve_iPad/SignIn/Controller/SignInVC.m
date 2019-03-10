//
//  SignInVC.m
//  meetingroom_reserve_iPad
//
//  Created by 张文轩 on 2019/1/21.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "SignInVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface SignInVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SignInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    //返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 50, 50)];
    [back setImage:[UIImage imageNamed:@"叉"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    //请对准摄像头
    UILabel *remind = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.15, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.1)];
    remind.text = @"请对准摄像头";
    remind.textAlignment = NSTextAlignmentCenter;
    remind.font = [UIFont systemFontOfSize:50 weight:20];
    remind.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:remind];
    //取像区域
    UIView *BCircleView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.3, SCREEN_HEIGHT*0.27, SCREEN_WIDTH*0.4, SCREEN_WIDTH*0.4)];
    BCircleView.layer.masksToBounds = YES;
    BCircleView.layer.cornerRadius = BCircleView.frame.size.width/2.0;
    BCircleView.layer.borderWidth = 7;
    BCircleView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:BCircleView];
    UIView *SCircleView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.33, SCREEN_HEIGHT*0.27+SCREEN_WIDTH*0.03, SCREEN_WIDTH*0.34, SCREEN_WIDTH*0.34)];
    SCircleView.layer.masksToBounds = YES;
    SCircleView.layer.cornerRadius = SCircleView.frame.size.width/2.0;
    SCircleView.layer.borderWidth = 2;
    SCircleView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:SCircleView];
}

- (void) back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        NSLog(@"没有摄像头");
    }
}
@end
