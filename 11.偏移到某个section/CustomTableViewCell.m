//
//  CustomTableViewCell.m
//  11.偏移到某个section
//
//  Created by apple on 2020/8/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "CustomTableViewCell.h"

#import "MainScrollView.h"

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setChilds];
  }
  return self;
}

- (void)setChilds{
  MainScrollView * scrollView = [[MainScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
  [self addSubview:scrollView];
  scrollView.contentSize = CGSizeMake(4 * scrollView.bounds.size.width, scrollView.bounds.size.height);
  scrollView.pagingEnabled = YES;
  
  for (NSInteger i = 0; i < 4; i ++) {
    UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(i * scrollView.bounds.size.width, 30, 50, 50)];
    [scrollView addSubview:lbl];
    lbl.text = [NSString stringWithFormat:@"%lu", i];
    lbl.backgroundColor = [UIColor redColor];
  }
  scrollView.backgroundColor = [UIColor greenColor];
}

@end
