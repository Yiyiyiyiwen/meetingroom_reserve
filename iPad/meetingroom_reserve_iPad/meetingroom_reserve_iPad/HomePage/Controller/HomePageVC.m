

//
//  HomePageVC.m
//  meetingroom_reserve_iPad
//
//  Created by 张文轩 on 2019/1/21.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "HomePageVC.h"
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
    UIView *currentMeetingRoom = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.05, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.9)];
    currentMeetingRoom.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPath1 = [UIBezierPath
                                bezierPathWithRect:currentMeetingRoom.bounds];
    currentMeetingRoom.layer.masksToBounds = NO;
    currentMeetingRoom.layer.shadowColor = [UIColor blackColor].CGColor;
    currentMeetingRoom.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    currentMeetingRoom.layer.shadowOpacity = 0.5f;
    currentMeetingRoom.layer.shadowPath = shadowPath1.CGPath;
    [self.view addSubview:currentMeetingRoom];
    UIView *innerView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, currentMeetingRoom.frame.size.width, currentMeetingRoom.frame.size.height)];
    innerView1.backgroundColor = [UIColor whiteColor];
    innerView1.layer.masksToBounds = YES;
    innerView1.layer.cornerRadius = 10;
    [currentMeetingRoom addSubview:innerView1];
    //显示全部
    UIView *showAll = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.55, SCREEN_HEIGHT*0.05, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.4)];
    showAll.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPath2 = [UIBezierPath
                                bezierPathWithRect:showAll.bounds];
    showAll.layer.masksToBounds = NO;
    showAll.layer.shadowColor = [UIColor blackColor].CGColor;
    showAll.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    showAll.layer.shadowOpacity = 0.5f;
    showAll.layer.shadowPath = shadowPath2.CGPath;
    [self.view addSubview:showAll];
    UIView *innerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, showAll.frame.size.width, showAll.frame.size.height)];
    innerView2.backgroundColor = [UIColor whiteColor];
    innerView2.layer.masksToBounds = YES;
    innerView2.layer.cornerRadius = 10;
    [showAll addSubview:innerView2];
    //签到
    UIView *signIn = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.55, SCREEN_HEIGHT*0.55, SCREEN_WIDTH*0.4, SCREEN_HEIGHT*0.4)];
    signIn.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPath3 = [UIBezierPath
                                 bezierPathWithRect:signIn.bounds];
    signIn.layer.masksToBounds = NO;
    signIn.layer.shadowColor = [UIColor blackColor].CGColor;
    signIn.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    signIn.layer.shadowOpacity = 0.5f;
    signIn.layer.shadowPath = shadowPath3.CGPath;
    [self.view addSubview:signIn];
    UIView *innerView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, signIn.frame.size.width, signIn.frame.size.height)];
    innerView3.backgroundColor = [UIColor whiteColor];
    innerView3.layer.masksToBounds = YES;
    innerView3.layer.cornerRadius = 10;
    [signIn addSubview:innerView3];
}

@end
