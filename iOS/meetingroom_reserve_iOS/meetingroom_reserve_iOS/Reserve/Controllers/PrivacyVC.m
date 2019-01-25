//
//  PrivacyVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/25.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "PrivacyVC.h"

@interface PrivacyVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PrivacyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"隐私";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *check = @"会议添加我是需要我的确认";
    NSString *block = @"屏蔽未知联系人消息";
    NSString *recommend = @"向我推荐通讯录朋友";
    NSArray *arr = [NSArray arrayWithObjects:check,block,recommend, nil];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.datas.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
        UISwitch *switchButton = [[UISwitch alloc]init];
        NSNumber *isOn;
        if (indexPath.row == 0) {
            isOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"P0"];
        }
        if (indexPath.row == 1) {
            isOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"P1"];
        }
        if (indexPath.row == 2) {
            isOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"P2"];
        }
        BOOL boolValue = [isOn boolValue];
        switchButton.on = boolValue;
        switchButton.tag = indexPath.row;
        [switchButton addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchButton;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.textLabel.text = @"通讯录黑名单";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) clickSwitch:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    NSInteger t = switchButton.tag;
    BOOL isButtonOn = [switchButton isOn];
    NSNumber *deal;
    if (isButtonOn) {
        deal = [NSNumber numberWithBool:YES];
    }else {
        deal = [NSNumber numberWithBool:NO];
    }
    if (t == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:deal forKey:@"P0"];
    }
    if (t == 1){
        [[NSUserDefaults standardUserDefaults] setObject:deal forKey:@"P1"];
    }
    if (t == 2){
        [[NSUserDefaults standardUserDefaults] setObject:deal forKey:@"P2"];
    }
}
@end
