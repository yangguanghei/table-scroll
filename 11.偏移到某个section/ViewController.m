//
//  ViewController.m
//  11.偏移到某个section
//
//  Created by apple on 2020/8/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ViewController.h"

#import <QMUIKit.h>
#import "CustomTableViewCell.h"
#import "ConatinTBTableViewCell.h"
#import "MainTableView.h"
#import "TableViewHeader.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MainTableView * tableView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) ConatinTBTableViewCell * subCell;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.view.backgroundColor = [UIColor greenColor];
  [self.view addSubview:self.tableView];
  
  UIColor * color = [[UIColor redColor] colorWithAlphaComponent:0.5];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage qmui_imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
  self.title = @"";
  self.canScroll = YES;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"mainCanScroll" object:nil];
}
// 主视图可以滚动的通知
- (void)changeScrollStatus{
    self.canScroll = YES;
    self.subCell.cellCanScroll = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
  CGFloat navigationBarH = self.navigationController.navigationBar.frame.size.height;
  CGFloat bottomCellOffset = [self.tableView rectForSection:3].origin.y - statusH - navigationBarH;
  
  if (scrollView.contentOffset.y >= bottomCellOffset) {   // 第二个sectionHeaderView滑动到顶部
    scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
    self.canScroll = NO;
    self.subCell.cellCanScroll = YES;
  }else{
    if (!self.canScroll) {
      scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
    }
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  NSInteger section = indexPath.section;
  if (section == 0 || section == 1) {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"123" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%lu区   第%lu行", indexPath.section, indexPath.row];
    return cell;
  }else if (section == 2){
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    return cell;
  }else{
    ConatinTBTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ConatinTBTableViewCell" forIndexPath:indexPath];
    CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationBarH = self.navigationController.navigationBar.frame.size.height;
    CGFloat cellHeight = [UIScreen mainScreen].bounds.size.height -  statusH - navigationBarH - 40;
    cell.cellHeight = cellHeight;
    self.subCell = cell;
    return cell;
  }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  NSInteger section = indexPath.section;
  if (section == 0 || section == 1) {
    return 44;
  }else if (section == 2){
    return 100;
  }else{
    CGFloat statusH = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationBarH = self.navigationController.navigationBar.frame.size.height;
    CGFloat cellHeight = [UIScreen mainScreen].bounds.size.height -  statusH - navigationBarH - 40;
    return cellHeight;
  }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0 || section == 1) {
    return 20;
  }else{
    return 1;
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  TableViewHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TableViewHeader"];
  header = [[TableViewHeader alloc] initWithReuseIdentifier:@"TableViewHeader"];
  header.contentView.backgroundColor = [UIColor redColor];
  header.titleLbl.text = [NSString stringWithFormat:@"第%lu个分区", section];
  header.titleLbl.backgroundColor = [UIColor greenColor];
  if (section == 3) {
    header.titleLbl.text = @"这个分区下嵌套了多个tableview，左右滑动试试";
  }
  return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return 40;
}

- (MainTableView *)tableView{
  if (_tableView == nil) {
    _tableView = [[MainTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"123"];
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"1"];
    [_tableView registerClass:[TableViewHeader class] forHeaderFooterViewReuseIdentifier:@"TableViewHeader"];
    [_tableView registerClass:[ConatinTBTableViewCell class] forCellReuseIdentifier:@"ConatinTBTableViewCell"];
  }
  return _tableView;
}


@end
