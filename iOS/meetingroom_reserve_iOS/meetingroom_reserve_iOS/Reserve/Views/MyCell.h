//
//  MyCell.h
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/9.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCell : UITableViewCell
@property(nonatomic,strong) UILabel * title;
@property(nonatomic,strong) UILabel * details;
@property(nonatomic,strong) UIImageView * image;
@end

NS_ASSUME_NONNULL_END
