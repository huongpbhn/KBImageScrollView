//
//  KBImageScrollViewController.h
//  KBImageScrollViewDemo
//
//  Created by Truong Minh Khoi on 1/28/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBImageScrollViewController : UIViewController

- (void)addImage:(UIImage *)image;

- (void)removeImage:(UIImage *)image;

- (void)insertImage:(UIImage *)image atIndex:(NSUInteger)index;

- (void)deleteImageAtIndex:(NSUInteger)index;

@property (nonatomic, copy) UIColor *backgroundColor;

@end
