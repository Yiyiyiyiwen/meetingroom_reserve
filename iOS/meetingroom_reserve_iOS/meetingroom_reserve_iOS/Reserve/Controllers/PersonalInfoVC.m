//
//  PersonalInfoVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2019/1/17.
//  Copyright © 2019 张文轩. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "SelectPhotoManager.h"
#import "YCPickerView.h"
#import "DataPickerView.h"
@interface PersonalInfoVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property(nonatomic,strong) NSDate *choseDate;
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UITextField *nameText;
@property(nonatomic,strong) UILabel *sexLabel;
@property(nonatomic,strong) UILabel *birthLabel;
@property(nonatomic,strong) YCPickerView *pickerView;
@property(nonatomic,strong) DataPickerView *datePicker;
@property(nonatomic,strong) SelectPhotoManager *photoManager;
@end

@implementation PersonalInfoVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    self.navigationItem.title = @"个人资料";
    self.choseDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"birth"];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _datas = [NSMutableArray arrayWithCapacity:0];
    NSString *icon = @"头像";
    NSString *nick = @"昵称";
    NSString *telNum = @"手机号";
    NSString *sex = @"性别";
    NSString *birth = @"生日";
    NSArray *arr = [NSArray arrayWithObjects:icon,nick,telNum,sex,birth, nil];
    [self.datas addObjectsFromArray:arr];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:229/255.0 blue:234/255.0 alpha:1.0];
    self.pickerView = [[YCPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    self.pickerView.arrPickerData = @[@"男",@"女"];
    [self.pickerView.pickerView selectRow:0 inComponent:0 animated:YES]; //pickerview默认选中行
    [self.view addSubview:self.pickerView];
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
    if (indexPath.row == 0){//头像
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.95, cell.frame.size.height*0.05, cell.frame.size.height*0.9, cell.frame.size.height*0.9)];
        self.image.layer.masksToBounds = YES;
        self.image.layer.cornerRadius = self.image.frame.size.width/2.0;
        UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
        if (img) {
            self.image.image = img;
        }
        [cell addSubview:self.image];
    }
    if (indexPath.row == 1) {//昵称
        self.nameText = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.7, cell.frame.size.height*0.05, cell.frame.size.width*0.36, cell.frame.size.height*0.9)];
        self.nameText.backgroundColor = [UIColor clearColor];
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        self.nameText.text = name;
        self.nameText.delegate = self;
        self.nameText.textAlignment = NSTextAlignmentRight;
        self.nameText.returnKeyType = UIReturnKeyDone;//Done按钮
        [cell addSubview:self.nameText];
    }
    if (indexPath.row == 2) {//手机号
        cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.77, cell.frame.size.height*0.05, cell.frame.size.width*0.36, cell.frame.size.height*0.9)];
        NSString *tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
        telLabel.text = tel;
        telLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:telLabel];
    }
    if (indexPath.row == 3) {//性别
        self.sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.7, cell.frame.size.height*0.05, cell.frame.size.width*0.36, cell.frame.size.height*0.9)];
        self.sexLabel.backgroundColor = [UIColor clearColor];
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
        self.sexLabel.text = name;
        self.sexLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:self.sexLabel];
    }
    if (indexPath.row == 4) {//生日
        self.birthLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width*0.7, cell.frame.size.height*0.05, cell.frame.size.width*0.36, cell.frame.size.height*0.9)];
        self.birthLabel.backgroundColor = [UIColor clearColor];
        //设置日期格式
        NSDateFormatter* format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        //变为数字
        NSString* birth = [format stringFromDate:self.choseDate];
        self.birthLabel.text = birth;
        self.birthLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:self.birthLabel];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {//头像
        [self keyboardResign];
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
    if (indexPath.row == 1) {//昵称
        [self.nameText becomeFirstResponder];
    }
    if (indexPath.row == 2) {//手机号
        [self keyboardResign];
    }
    if (indexPath.row == 3) {//性别
        [self keyboardResign];
        [self.pickerView popPickerView];
        __block PersonalInfoVC * blockSelf = self;
        self.pickerView.selectBlock = ^(NSString *str) {
            blockSelf.sexLabel.text = str;
            [[NSUserDefaults standardUserDefaults] setObject:blockSelf.sexLabel.text forKey:@"sex"];
        };
    }
    if (indexPath.row == 4) {//生日
        [self keyboardResign];
        self.datePicker = [[DataPickerView alloc] initWithFrame:self.view.bounds
                                                 datePickerMode:UIDatePickerModeDate
                                                       lastDate:self.choseDate];
        [self.datePicker showView];
        __weak __typeof(self)weakSelf = self;
        [self.datePicker confirmDate:^(NSDate *date) {
            weakSelf.choseDate = date;
            //设置日期格式
            NSDateFormatter* format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            //变为数字
            NSString* birth = [format stringFromDate:date];
            weakSelf.birthLabel.text = birth;
            [[NSUserDefaults standardUserDefaults] setObject:weakSelf.choseDate forKey:@"birth"];
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self.nameText isExclusiveTouch]) {
        [self.nameText resignFirstResponder];
        [[NSUserDefaults standardUserDefaults] setObject:self.nameText.text forKey:@"userName"];
    }
    return YES;
}

//键盘弹回
- (void) keyboardResign {
    if ([self.nameText isFirstResponder]) {
        [self.nameText resignFirstResponder];
        [[NSUserDefaults standardUserDefaults] setObject:self.nameText.text forKey:@"userName"];
    }
}
@end
