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
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;

@end

@implementation KBZoomableImageView

#pragma mark - Init

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
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
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.container.frame = self.bounds;
    self.maximumZoomScale = MAX([self actualSizeImageScale], self.minimumZoomScale);
    [self layoutImageView];
}

#pragma mark - Setup Views

- (void)setupView {
    self.container = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.container];
    [self configureContainerScrollView];
    [self addDoubleTapGestureRecognizer];
    [self disableZooming];
    
    self.imageView = [[UIImageView alloc] init];
    [self.container addSubview:self.imageView];
    [self configureImageView];
}

- (void)configureContainerScrollView {
    self.container.delegate = self;
    self.container.showsHorizontalScrollIndicator = KBDefaultShowsScrollIndicator;
    self.container.showsVerticalScrollIndicator = KBDefaultShowsScrollIndicator;
    self.container.pagingEnabled = NO;
    self.container.minimumZoomScale = KBDefaultMinimumZoomScale;
    self.container.maximumZoomScale = KBDefaultMaximumZoomScale;
    self.container.userInteractionEnabled = YES;
    self.container.contentSize = self.bounds.size;
}

- (void)addDoubleTapGestureRecognizer {
    self.doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerDidDoubleTap:)];
    self.doubleTapGesture.numberOfTapsRequired = 2;
    [self.container addGestureRecognizer:self.doubleTapGesture];
}

- (void)containerDidDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.container.zoomScale == self.container.minimumZoomScale) {
            self.container.zoomScale = self.maximumZoomScale;
        } else {
            self.container.zoomScale = self.minimumZoomScale;
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)configureImageView {
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.userInteractionEnabled = YES;
}

#pragma mark - Accessors

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
    [self layoutIfNeeded];
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

- (void)disableZooming {
    self.maximumZoomScale = self.minimumZoomScale;
}

- (void)enableZooming {
    self.maximumZoomScale = self.maximumZoomScale;
}

#pragma mark - Scroll view's delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self layoutImageView];
}

- (void)layoutImageView {
    CGFloat containerWidth = self.container.bounds.size.width;
    CGFloat containerHeight = self.container.bounds.size.height;
    CGFloat imageWidth = self.image.size.width;
    CGFloat imageHeight = self.image.size.height;
    
    if (imageWidth <= 0 || imageHeight <= 0) {
        return;
    }
    
    CGFloat fitImageScale = [self fitImageScale];
    
    CGFloat imageViewWidth = imageWidth * fitImageScale * self.zoomScale;
    CGFloat imageViewHeight = imageHeight * fitImageScale * self.zoomScale;
    
    CGFloat imageViewX = MAX(0, (containerWidth - imageViewWidth) / 2);
    CGFloat imageViewY = MAX(0, (containerHeight - imageViewHeight) / 2);
    
    CGFloat contentWidth = imageViewX * 2 + imageViewWidth;
    CGFloat contentHeight = imageViewY * 2 + imageViewHeight;
    
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    self.container.contentSize = CGSizeMake(contentWidth, contentHeight);
    if (self.zoomScale == 1) {
        self.container.contentSize = self.container.bounds.size;
    }
}

- (double)fitImageScale {
    CGFloat containerWidth = self.container.bounds.size.width;
    CGFloat containerHeight = self.container.bounds.size.height;
    CGFloat imageWidth = self.image.size.width;
    CGFloat imageHeight = self.image.size.height;
    
    if (imageWidth <= 0 || imageHeight <= 0) {
        return 1;
    }
    
    CGFloat imageScale = MIN(containerWidth / imageWidth, containerHeight / imageHeight);
    return imageScale;
}

- (CGFloat)actualSizeImageScale {
    CGFloat scale = 1 / [self fitImageScale];
    return scale;
}

@end
