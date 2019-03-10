//
//  shadowView.m
//  meetingroom_reserve_iPad
//
//  Created by 张文轩 on 2019/1/21.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "shadowView.h"

@implementation shadowView

- (void)createLargeView:(NSString*)largeTitle{
    CGFloat SCREEN_WIDTH = self.frame.size.width;
    CGFloat SCREEN_HEIGHT = self.frame.size.height;
    //阴影
    UIView *shadow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    shadow.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPath = [UIBezierPath
                                 bezierPathWithRect:shadow.bounds];
    shadow.layer.masksToBounds = NO;
    shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    shadow.layer.shadowOpacity = 0.5f;
    shadow.layer.shadowPath = shadowPath.CGPath;
    [self addSubview:shadow];
    //背景
    UIView *innerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, shadow.frame.size.width, shadow.frame.size.height)];
    innerView.backgroundColor = [UIColor whiteColor];
    innerView.layer.masksToBounds = YES;
    innerView.layer.cornerRadius = 10;
    [shadow addSubview:innerView];
    //标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.1, SCREEN_WIDTH*0.1, SCREEN_WIDTH*0.5, SCREEN_WIDTH*0.1)];
    title.text = largeTitle;
    title.textColor = [UIColor colorWithRed:105.0/255.0 green:110.0/255.0 blue:237.0/255.0 alpha:1.0];
    title.font = [UIFont systemFontOfSize:40 weight:20];
    [self addSubview:title];
}

- (void)createSmallView:(NSString*)smallTitle withImage:(UIImage*)image{
    CGFloat SCREEN_WIDTH = self.frame.size.width;
    CGFloat SCREEN_HEIGHT = self.frame.size.height;
    //阴影
    UIView *shadow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    shadow.backgroundColor = [UIColor clearColor];
    UIBezierPath *shadowPath = [UIBezierPath
                                bezierPathWithRect:shadow.bounds];
    shadow.layer.masksToBounds = NO;
    shadow.layer.shadowColor = [UIColor blackColor].CGColor;
    shadow.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    shadow.layer.shadowOpacity = 0.5f;
    shadow.layer.shadowPath = shadowPath.CGPath;
    [self addSubview:shadow];
    //背景
    UIView *innerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, shadow.frame.size.width, shadow.frame.size.height)];
    innerView.backgroundColor = [UIColor whiteColor];
    innerView.layer.masksToBounds = YES;
    innerView.layer.cornerRadius = 10;
    [shadow addSubview:innerView];
    //标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, 0, SCREEN_WIDTH*0.5, SCREEN_HEIGHT)];
    title.text = smallTitle;
    title.textColor = [UIColor grayColor];
    title.font = [UIFont systemFontOfSize:25];
    [self addSubview:title];
    //图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_HEIGHT*0.6, SCREEN_HEIGHT*0.25, SCREEN_HEIGHT*0.5, SCREEN_HEIGHT*0.5)];
    imageView.image = image;
    [self addSubview:imageView];
}

@end
