//
//  TableViewHeader.m
//  11.偏移到某个section
//
//  Created by apple on 2020/8/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "TableViewHeader.h"

@implementation TableViewHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithReuseIdentifier:reuseIdentifier];
  if (self) {
    [self setSubviews];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    [self setSubviews];
  }
  return self;
}

- (instancetype)init{
  self = [super init];
  if (self) {
    [self setSubviews];
  }
  return self;
}

- (void)setSubviews{
  [self addSubview:self.titleLbl];
  self.titleLbl.frame = CGRectMake(15, 0, 360, 20);
}

#pragma mark --- 懒加载
- (UILabel *)titleLbl{
  if (_titleLbl == nil) {
    _titleLbl = [UILabel new];
  }
  return _titleLbl;
}

@end
