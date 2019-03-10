

//
//  HomePageVC.m
//  meetingroom_reserve_iPad
//
//  Created by 张文轩 on 2019/1/21.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "HomePageVC.h"
#import "shadowView.h"
#import "SignInVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface HomePageVC ()

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229.0/255.0 blue:234.0/255.0 alpha:1.0];
    //当前会议室
    shadowView *currentMeetingRoom = [[shadowView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.05, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.9)];
    [currentMeetingRoom createLargeView:@"当前会议室"];
    [self.view addSubview:currentMeetingRoom];
    shadowView *roomDetail = [[shadowView alloc]initWithFrame:CGRectMake(currentMeetingRoom.frame.size.width*0.1, currentMeetingRoom.frame.size.width*0.3, currentMeetingRoom.frame.size.width*0.8, currentMeetingRoom.frame.size.width*0.2)];
    [roomDetail createSmallView:@"301会议室" withImage:[UIImage imageNamed:@"会议室"]];
    [currentMeetingRoom addSubview:roomDetail];
    //显示全部
    shadowView *showAll = [[shadowView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.55, SCREEN_HEIGHT*0.05, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.4)];
    [showAll createLargeView:@"我要预订"];
    [self.view addSubview:showAll];
    shadowView *showDetail = [[shadowView alloc]initWithFrame:CGRectMake(showAll.frame.size.width*0.1, showAll.frame.size.width*0.3, showAll.frame.size.width*0.8, showAll.frame.size.width*0.2)];
    [showDetail createSmallView:@"预订" withImage:[UIImage imageNamed:@"预定"]];
    [showAll addSubview:showDetail];
    //签到
    shadowView *signIn = [[shadowView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.55, SCREEN_HEIGHT*0.55, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.4)];
    UITapGestureRecognizer *signin = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(signInAct)];
    [signIn addGestureRecognizer:signin];
    [signIn createLargeView:@"签到"];
    [self.view addSubview:signIn];
    shadowView *signInDetail = [[shadowView alloc]initWithFrame:CGRectMake(signIn.frame.size.width*0.1, signIn.frame.size.width*0.3, signIn.frame.size.width*0.8, signIn.frame.size.width*0.2)];
    [signInDetail createSmallView:@"签到" withImage:[UIImage imageNamed:@"人脸识别"]];
    [signIn addSubview:signInDetail];
}

- (void)signInAct{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SignInVC *vc = [sb instantiateViewControllerWithIdentifier:@"SignIn"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
