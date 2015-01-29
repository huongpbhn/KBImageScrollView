//
//  KBImageScrollView.h
//  KBImageScrollView
//
//  Created by Truong Minh Khoi on 1/27/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KBImageScrollView;

@protocol KBImageScrollViewDelegate <NSObject>

@optional

- (void)imageScrollView:(KBImageScrollView *)imageScrollView didScrollToImage:(UIImage *)image atIndex:(NSUInteger)index;

@end

@interface KBImageScrollView : UIView

- (void)addImage:(UIImage *)image;

- (void)removeImage:(UIImage *)image;

- (void)insertImage:(UIImage *)image atIndex:(NSUInteger)index;

- (void)deleteImageAtIndex:(NSUInteger)index;

@property (nonatomic, assign) id <KBImageScrollViewDelegate> delegate;

@property (nonatomic) NSUInteger currentPage;

@end
