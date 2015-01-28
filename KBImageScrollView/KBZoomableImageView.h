//
//  KBZoomableImageView.h
//  KBImageScrollView
//
//  Created by Truong Minh Khoi on 1/27/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBZoomableImageView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithImage:(UIImage *)image;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic) CGFloat minimumZoomScale;
@property (nonatomic) CGFloat maximumZoomScale;
@property (nonatomic) BOOL showsScrollIndicator;
@property (nonatomic) CGFloat zoomScale;

@end
