//
//  UIImage+XG.h
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/1.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage_XG : UIImage
/**
 *  @param icon         头像图片名称
 *  @param borderImage  边框的图片名称
 *  @param border       边框大小
 *
 *  @return 圆形的头像图片
 */
+ (instancetype)imageWithIconName:(NSString *)icon borderImage:(NSString *)borderImage border:(int)border;
@end

NS_ASSUME_NONNULL_END
