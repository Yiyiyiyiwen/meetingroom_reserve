
//
//  GenralVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/25.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "GenralVC.h"

@interface GenralVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GenralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"通用";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *font = @"字体大小";
    NSString *mutilLang = @"多语言";
    NSString *skin = @"使用默认皮肤";
    NSArray *arr = [NSArray arrayWithObjects:font,mutilLang,skin, nil];
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
        if (indexPath.row == 2) {
            UISwitch *switchButton = [[UISwitch alloc]init];
            NSNumber *isOn;
            isOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"G2"];
            BOOL boolValue = [isOn boolValue];
            switchButton.on = boolValue;
            switchButton.tag = indexPath.row;
            [switchButton addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchButton;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        cell.textLabel.text = @"一键清理";
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
    if (t == 2){
        [[NSUserDefaults standardUserDefaults] setObject:deal forKey:@"G2"];
    }
}
@end
