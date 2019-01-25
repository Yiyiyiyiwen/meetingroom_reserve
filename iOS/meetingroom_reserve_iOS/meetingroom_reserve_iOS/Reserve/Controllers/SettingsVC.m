//
//  SettingsVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/17.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "SettingsVC.h"
#import "PrivacyVC.h"
#import "GenralVC.h"
#import "AboutVC.h"
@interface SettingsVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"设置";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *privacy = @"隐私";
    NSString *general = @"通用";
    NSString *about = @"关于会议室管理系统";
    NSArray *arr = [NSArray arrayWithObjects:privacy,general,about, nil];
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            PrivacyVC *privacy = [sb instantiateViewControllerWithIdentifier:@"Privacy"];
            [self.navigationController pushViewController:privacy animated:YES];
        }
        if (indexPath.row == 1) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            GenralVC *genral = [sb instantiateViewControllerWithIdentifier:@"Genral"];
            [self.navigationController pushViewController:genral animated:YES];
        }
        if (indexPath.row == 2) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            AboutVC *about = [sb instantiateViewControllerWithIdentifier:@"About"];
            [self.navigationController pushViewController:about animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"退出后，您将不再收到消息" preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //获取UserDefaults单例
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                //移除UserDefaults中存储的用户信息
                [userDefaults removeObjectForKey:@"tel"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults synchronize];
                //获取storyboard
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                //获取注销后要跳转的页面
                id view = [storyboard instantiateViewControllerWithIdentifier:@"LogIn"];
                //模态展示出登陆页面
                [self presentViewController:view animated:YES completion:^{
                }];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
