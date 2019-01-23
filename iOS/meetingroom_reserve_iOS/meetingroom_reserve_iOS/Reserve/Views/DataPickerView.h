//
//  DataPickerView.h
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/23.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DateType) {
    DateTypeNormal,       // 默认时间选择(月日时分)
    DateTypeModeDate      // 时间选择(只有年月日)
};

typedef void (^ConfirmDateBlock)(NSDate  *date);

@interface DataPickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
               datePickerMode:(UIDatePickerMode)datePickerMode
                     lastDate:(NSDate *)lastDate;

/**
 *  View显示
 */
- (void)showView;

/**
 *  确认所选时间
 *
 *  @param block 传出Date
 */
- (void)confirmDate:(ConfirmDateBlock)block;

@end


NS_ASSUME_NONNULL_END



