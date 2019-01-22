//
//  PersonalInfoVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/17.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "SelectPhotoManager.h"
@interface PersonalInfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) UIImageView * image;
@property (nonatomic, strong)SelectPhotoManager *photoManager;
@end

@implementation PersonalInfoVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"个人资料";
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *icon = @"头像";
    NSString *nick = @"昵称";
    NSString *telNum = @"电话";
    NSString *sex = @"性别";
    NSString *birth = @"生日";
    NSArray *arr = [NSArray arrayWithObjects:icon,nick,telNum,sex,birth, nil];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
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
    if (indexPath.row == 0){
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.95, cell.frame.size.height*0.05, cell.frame.size.height*0.9, cell.frame.size.height*0.9)];
        self.image.layer.masksToBounds = YES;
        self.image.layer.cornerRadius = self.image.frame.size.width/2.0;
        UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
        if (img) {
            self.image.image = img;
        }
        [cell addSubview:self.image];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        if (!_photoManager) {
            _photoManager =[[SelectPhotoManager alloc]init];
        }
        [_photoManager startSelectPhotoWithImageName:@"选择头像"];
        __weak typeof(self)mySelf=self;
        //选取照片成功
        _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
            mySelf.image.image = image;
            //保存到本地
            NSData *data = UIImagePNGRepresentation(image);
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
        };
    }
}
@end
