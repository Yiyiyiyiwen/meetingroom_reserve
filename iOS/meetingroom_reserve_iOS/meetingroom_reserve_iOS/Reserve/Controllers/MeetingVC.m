//
//  MeetingVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/8.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "MeetingVC.h"

@interface MeetingVC ()

@end

@implementation MeetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbarItem];
    self.navigationItem.title = @"会议";
}

- (void) initTabbarItem{
    UITabBarItem *item0 = [self.tabBarController.tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [self.tabBarController.tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [self.tabBarController.tabBar.items objectAtIndex:2];
    [item0 setTitle:@"会议"];
    [item0 setImage:[UIImage imageNamed:@"会议未选中"]];
    [item0 setSelectedImage:[UIImage imageNamed:@"会议选中"]];
    [item1 setTitle:@"预定"];
    [item1 setImage:[UIImage imageNamed:@"预定未选中"]];
    [item1 setSelectedImage:[UIImage imageNamed:@"预定选中"]];
    [item2 setTitle:@"我的"];
    [item2 setImage:[UIImage imageNamed:@"我的未选中"]];
    [item2 setSelectedImage:[UIImage imageNamed:@"我的选中"]];
}


@end
