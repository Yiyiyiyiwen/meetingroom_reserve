//
//  YCPickerView.h
//  VolleyballSystem
//
//  Created by 张文轩 on 2017/11/4.
//  Copyright © 2017年 张文轩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBasicBlock)(id result);

@interface YCPickerView : UIView

@property (retain, nonatomic) NSArray *arrPickerData;
@property (retain, nonatomic) UIPickerView *pickerView;

@property (nonatomic, copy) MyBasicBlock selectBlock;

- (void)popPickerView;

@end
