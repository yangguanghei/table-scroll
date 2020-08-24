//
//  MainTableView.m
//  11.偏移到某个section
//
//  Created by apple on 2020/8/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MainTableView.h"

#import "MainScrollView.h"

@implementation MainTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//  NSLog(@"gestureRecognizerView:%@", gestureRecognizer.view);
//  NSLog(@"^^^^^^^^^^^😄😄😄😄😄😄😄😄😄😄😄😄^^^^^^^^^^^^^^^^^");
//  NSLog(@"otherGestureRecognizerView:%@", otherGestureRecognizer.view);
  if ([otherGestureRecognizer.view isKindOfClass:[MainScrollView class]]) {
    return NO;
  }
    return YES;
  
//  return NO;
}

@end
