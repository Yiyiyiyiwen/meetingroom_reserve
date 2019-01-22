//
//  MyVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/8.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "MyVC.h"
#import "UIImage+XG.h"
#import "PersonalInfoVC.h"
#import "NoteVC.h"
#import "CardsVC.h"
#import "SettingsVC.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
@interface MyVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) UIImageView * headImageView;
@end

@implementation MyVC

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithCapacity:0];
        NSString *personalInfo = @"个人资料";
        NSString *meetingNote = @"会议笔记";
        NSString *digitalCards = @"电子卡包";
        NSString *setting = @"设置";
        NSArray *arr = [NSArray arrayWithObjects:personalInfo,meetingNote,digitalCards,setting, nil];
        [self.datas addObjectsFromArray:arr];
    }
    return _datas;
}

- (void)viewWillAppear:(BOOL)animated{
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
    }
    self.tabBarController.tabBar.hidden = NO;
    UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (img) {
        self.headImageView.image = img;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
    }
    self.navigationItem.title = @"我的";
    [self initUI];
}

- (void) initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.13, SCREEN_WIDTH, SCREEN_HEIGHT*0.33)];
    [self.view addSubview:topView];
    //头像
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(topView.frame.size.width*0.35, topView.frame.size.height*0.2, topView.frame.size.width*0.30, topView.frame.size.width*0.30)];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2.0;
    UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (img) {
        self.headImageView.image = img;
    }
    [topView addSubview:self.headImageView];
    //姓名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(topView.frame.size.width*0.35, topView.frame.size.height*0.8, topView.frame.size.width*0.3, topView.frame.size.height*0.1)];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    if (@available(iOS 11.0, *)) {
        if (window.safeAreaInsets.bottom > 0.0) {
            nameLabel.frame = CGRectMake(topView.frame.size.width*0.35, topView.frame.size.height*0.65, topView.frame.size.width*0.3, topView.frame.size.height*0.1);
        } else {
        }
    } else {
    }
    nameLabel.text = @"王 先 生";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:20];
    [topView addSubview:nameLabel];
    self.tableView.tableHeaderView = topView;
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        PersonalInfoVC *personalInfoVC = [sb instantiateViewControllerWithIdentifier:@"PersonalInfo"];
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.prefersLargeTitles = NO;
        } else {
        }
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:personalInfoVC animated:YES];
    }
    if (indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        NoteVC *note = [sb instantiateViewControllerWithIdentifier:@"Note"];
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.prefersLargeTitles = NO;
        } else {
        }
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:note animated:YES];
    }
    if (indexPath.row == 2) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CardsVC *cards = [sb instantiateViewControllerWithIdentifier:@"Cards"];
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.prefersLargeTitles = NO;
        } else {
        }
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:cards animated:YES];
    }
    if (indexPath.row == 3) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SettingsVC *settings = [sb instantiateViewControllerWithIdentifier:@"Settings"];
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.prefersLargeTitles = NO;
        } else {
        }
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:settings animated:YES];
    }
}




@end
