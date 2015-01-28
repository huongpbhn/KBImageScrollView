//
//  KBZoomableImageView.m
//  KBImageScrollView
//
//  Created by Truong Minh Khoi on 1/27/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import "KBZoomableImageView.h"

#define KBDefaultMinimumZoomScale       1.0f
#define KBDefaultMaximumZoomScale       1.0f
#define KBDefaultShowsScrollIndicator   YES

@interface KBZoomableImageView () <UIScrollViewDelegate> {
    UIImage *_image;
}

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation KBZoomableImageView

#pragma mark - Init

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
        [self setupView];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self setImage:image];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setupView];
        [self setFrame:frame];
    }
    return self;
}

- (void)initData {
    self.minimumZoomScale = KBDefaultMinimumZoomScale;
    self.maximumZoomScale = KBDefaultMaximumZoomScale;
    self.showsScrollIndicator = KBDefaultShowsScrollIndicator;
}

#pragma mark - Setup Views

- (void)setupView {
    self.container = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.container];
    [self configureContainerScrollView];
    [self disableZooming];
    
    self.imageView = [[UIImageView alloc] init];
    [self.container addSubview:self.imageView];
    [self configureImageView];
}

- (void)configureContainerScrollView {
    self.container.delegate = self;
    self.container.showsHorizontalScrollIndicator = self.showsScrollIndicator;
    self.container.showsVerticalScrollIndicator = self.showsScrollIndicator;
    self.container.pagingEnabled = NO;
    self.container.minimumZoomScale = self.minimumZoomScale;
    self.container.maximumZoomScale = self.maximumZoomScale;
    self.container.userInteractionEnabled = YES;
    self.container.contentSize = self.bounds.size;
}

- (void)configureImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.userInteractionEnabled = YES;
}

#pragma mark - Accessors

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.container.frame = self.bounds;
    [self fitImageView];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [self.container setBackgroundColor:backgroundColor];
    [self.imageView setBackgroundColor:backgroundColor];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    if (!image) {
        return;
    }
    
    self.imageView.image = self.image;
    [self fitImageView];
    [self enableZooming];
}

- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale {
    self.container.minimumZoomScale = minimumZoomScale;
}

- (CGFloat)minimumZoomScale {
    return self.container.minimumZoomScale;
}

- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale {
    self.container.maximumZoomScale = maximumZoomScale;
}

- (CGFloat)maximumZoomScale {
    return self.container.maximumZoomScale;
}

- (void)setShowsScrollIndicator:(BOOL)showsScrollIndicator {
    self.container.showsHorizontalScrollIndicator = showsScrollIndicator;
    self.container.showsVerticalScrollIndicator = showsScrollIndicator;
}

- (void)setZoomScale:(CGFloat)zoomScale {
    [self.container setZoomScale:zoomScale];
}

- (CGFloat)zoomScale {
    return self.container.zoomScale;
}

#pragma mark -

- (void)fitImageView {
    self.container.zoomScale = self.minimumZoomScale;
    
    if (!self.image) {
        return;
    }
    
    CGFloat containerWidth = self.container.bounds.size.width;
    CGFloat containerHeight = self.container.bounds.size.height;
    CGFloat imageWidth = self.image.size.width;
    CGFloat imageHeight = self.image.size.height;
    
    CGFloat imageScale = MIN(containerWidth / imageWidth, containerHeight / imageHeight);
    
    CGFloat imageViewWidth = imageWidth * imageScale;
    CGFloat imageViewHeight = imageHeight * imageScale;
    
    self.imageView.bounds = CGRectMake(0, 0, imageViewWidth, imageViewHeight);
    self.imageView.center = self.container.center;
}

- (void)disableZooming {
    self.container.minimumZoomScale = self.minimumZoomScale;
    self.container.maximumZoomScale = self.minimumZoomScale;
}

- (void)enableZooming {
    self.container.minimumZoomScale = self.minimumZoomScale;
    self.container.maximumZoomScale = self.maximumZoomScale;
}

#pragma mark - Scroll view's delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([[scrollView.subviews firstObject] isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = [scrollView.subviews firstObject];
        
        CGFloat imageViewWidth = imageView.frame.size.width;
        CGFloat imageViewHeight = imageView.frame.size.height;
        CGFloat containerWidth = self.container.bounds.size.width;
        CGFloat containerHeight = self.container.bounds.size.height;
        
        CGFloat imageViewX = MAX(0, (containerWidth - imageViewWidth) / 2);
        CGFloat imageViewY = MAX(0, (containerHeight - imageViewHeight) / 2);
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    }
}

@end
