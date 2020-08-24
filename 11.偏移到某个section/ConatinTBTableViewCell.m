//
//  ConatinTBTableViewCell.m
//  11.偏移到某个section
//
//  Created by apple on 2020/8/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ConatinTBTableViewCell.h"

#import "SubTableView.h"
#import "MainScrollView.h"

@interface ConatinTBTableViewCell ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * subTableviews;

@end

@implementation ConatinTBTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
//    [self setChilds];
  }
  return self;
}

- (void)setCellHeight:(CGFloat)cellHeight{
  if (_cellHeight > 0) {
    return;
  }
  _cellHeight = cellHeight;
  [self setChilds];
}

- (void)setCellCanScroll:(BOOL)cellCanScroll{
  _cellCanScroll = cellCanScroll;
  for (SubTableView * tableView in self.subTableviews) {
    tableView.canScroll = cellCanScroll;
    if (cellCanScroll) {
//      NSLog(@"可以滑动了...");
    }else{
      tableView.contentOffset = CGPointZero;
    }
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
  NSInteger viewTag = scrollView.tag;
  
  for (NSInteger i = 0; i < self.subTableviews.count; i ++) {
    if (viewTag == i) {
      SubTableView * tableview = self.subTableviews[i];
      if (tableview.canScroll) {
//        NSLog(@"😄😄😄😄😄😄😄😄");
      }else{
        tableview.contentOffset = CGPointZero;
      }
      if (tableview.contentOffset.y <= 0) {
          tableview.canScroll = NO;
          tableview.contentOffset = CGPointZero;
          [[NSNotificationCenter defaultCenter] postNotificationName:@"mainCanScroll" object:nil];//到顶通知父视图改变状态
      }
    }
  }
  
}

- (void)setChilds{
  
  MainScrollView * scrollView = [[MainScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cellHeight)];
  [self addSubview:scrollView];
  scrollView.contentSize = CGSizeMake(4 * scrollView.bounds.size.width, scrollView.bounds.size.height);
  scrollView.pagingEnabled = YES;
  
  for (NSInteger i = 0; i < 4; i ++) {
    SubTableView * tableview = [[SubTableView alloc] initWithFrame:CGRectMake(i * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [scrollView addSubview:tableview];
    tableview.tag = i;
    [self.subTableviews addObject:tableview];
  }
  scrollView.backgroundColor = [UIColor greenColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@"%lu", indexPath.row];
  return cell;
}


- (NSMutableArray *)subTableviews{
  if (_subTableviews == nil) {
    _subTableviews = [NSMutableArray array];
  }
  return _subTableviews;
}
@end
