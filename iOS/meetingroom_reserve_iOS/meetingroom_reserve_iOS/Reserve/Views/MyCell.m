//
//  MyCell.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/9.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "MyCell.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@implementation MyCell

//- (void)setFrame:(CGRect)frame{
////    frame.origin.x += 10;
//    frame.origin.y += 10;
//    frame.size.height -= 10;
////    frame.size.width -= 20;
//    [super setFrame:frame];
//}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *grayBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.frame.size.height)];
        grayBack.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
        [self.contentView addSubview:grayBack];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(grayBack.frame.size.width*0.05, grayBack.frame.size.width*0.05, grayBack.frame.size.width*0.9, SCREEN_HEIGHT*0.1)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 5;
        backView.layer.shadowOpacity = 0.5;// 阴影透明度
        backView.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius = 3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(4, 4);// 阴影的范围
        [grayBack addSubview:backView];
        self.title  = [[UILabel alloc]initWithFrame:CGRectMake(backView.frame.size.width*0.1, backView.frame.size.height*0.3, backView.frame.size.width*0.3, backView.frame.size.height*0.4)];
        self.details = [[UILabel alloc]initWithFrame:CGRectMake(backView.frame.size.width*0.4, backView.frame.size.height*0.1, backView.frame.size.width*0.4, backView.frame.size.height*0.8)];
        self.image  = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width*0.8, backView.frame.size.height*0.3, backView.frame.size.width*0.2, backView.frame.size.height*0.4)];
        [backView addSubview:self.details];
        [backView addSubview:self.image];
        [backView addSubview:self.title];
    }
    return self;
}

@end
