//
//  LogInVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/1.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "LogInVC.h"

@interface LogInVC ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UISetting];
}

- (void) UISetting{
    self.backgroundView.backgroundColor = [UIColor greenColor];
}
@end
