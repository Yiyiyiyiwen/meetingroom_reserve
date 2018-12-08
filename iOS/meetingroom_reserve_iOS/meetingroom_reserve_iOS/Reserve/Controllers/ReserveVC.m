//
//  ReserveVC.m
//  meetingroom_reserve_iOS
//
//  Created by 张文轩 on 2018/12/8.
//  Copyright © 2018 张文轩. All rights reserved.
//

#import "ReserveVC.h"

@interface ReserveVC ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@end

@implementation ReserveVC

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
        NSArray *arr = [[NSArray alloc]initWithObjects:@"111",@"测试2",@"测试3",@"测试3",@"测试4",@"测试5",@"测试6", nil];
        [self.datas addObjectsFromArray:arr];
    }
    return _datas;
}

- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    return _results;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void) initUI{
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    searchController.searchResultsUpdater = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController = searchController;
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
    }
    self.tableView.tableHeaderView = searchController.searchBar;
    self.navigationItem.title = @"预定";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active) {
        return self.results.count ;
    }
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active ) {
        cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchController.active) {
        NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
    } else {
        NSLog(@"选择了列表中的%@", [self.datas objectAtIndex:indexPath.row]);
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputStr = searchController.searchBar.text ;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            [self.results addObject:str];
        }
    }
    [self.tableView reloadData];
}


@end
