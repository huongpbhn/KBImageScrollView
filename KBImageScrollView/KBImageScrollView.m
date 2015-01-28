//
//  KBImageScrollView.m
//  KBImageScrollView
//
//  Created by Truong Minh Khoi on 1/27/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import "KBImageScrollView.h"
#import "KBZoomableImageView.h"

@interface KBImageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) NSMutableArray *zoomableImageViews;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation KBImageScrollView

#pragma mark - Init

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
        [self setupView];
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
    self.zoomableImageViews = [NSMutableArray array];
    self.images = [NSMutableArray array];
    self.currentPage = 0;
}

#pragma mark - Setup views

- (void)setupView {
    self.container = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.container];
    [self configureContainerScrollView];
}

- (void)configureContainerScrollView {
    self.container.delegate = self;
    self.container.showsHorizontalScrollIndicator = NO;
    self.container.showsVerticalScrollIndicator = NO;
    self.container.pagingEnabled = YES;
    self.container.minimumZoomScale = 1.0f;
    self.container.maximumZoomScale = 1.0f;
    self.container.userInteractionEnabled = YES;
    self.container.contentSize = CGSizeZero;
}

#pragma mark - Accessors

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.container.frame = self.bounds;
}

#pragma mark -

- (void)addImage:(UIImage *)image {
    [self insertImage:image atIndex:self.images.count];
}

- (void)insertImage:(UIImage *)image atIndex:(NSUInteger)index {
    NSAssert(image, @"Cannot add nil image");
    [self.images insertObject:image atIndex:index];
    [self insertZoomableImageViewForImage:image atIndex:index];
}

- (void)insertZoomableImageViewForImage:(UIImage *)image atIndex:(NSUInteger)index {
    KBZoomableImageView *imageView = [[KBZoomableImageView alloc] initWithImage:image];
    imageView.minimumZoomScale = 1.0f;
    imageView.maximumZoomScale = 3.0f;
    imageView.showsScrollIndicator = YES;
    [self.container addSubview:imageView];
    [self.zoomableImageViews insertObject:imageView atIndex:index];
    
    [self updateImageViewFrames];
}

- (void)updateImageViewFrames {
    CGFloat contentWidth = self.zoomableImageViews.count * self.container.bounds.size.width;
    CGFloat contentHeight = self.container.bounds.size.height;
    self.container.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    for (NSUInteger i = 0; i < self.zoomableImageViews.count; i++) {
        KBZoomableImageView *imageView = self.zoomableImageViews[i];
        CGFloat imageViewWidth = self.bounds.size.width;
        CGFloat imageViewHeight = self.bounds.size.height;
        CGFloat imageViewX = i * imageViewWidth;
        CGFloat imageViewY = 0;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    }
}

@end
