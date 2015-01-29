//
//  KBImageScrollView.m
//  KBImageScrollView
//
//  Created by Truong Minh Khoi on 1/27/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import "KBImageScrollView.h"
#import "KBZoomableImageView.h"

@interface KBImageScrollView () <UIScrollViewDelegate> {
    NSMutableArray *_images;
}

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) NSMutableArray *zoomableImageViews;

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
    _images = [[NSMutableArray alloc] init];
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
    NSUInteger currentPage = self.currentPage;
    self.container.frame = self.bounds;
    self.currentPage = currentPage;
    for (NSUInteger index = 0; index < self.zoomableImageViews.count; index++) {
        [self layoutImageViewAtIndex:index];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [self.container setBackgroundColor:backgroundColor];
    for (KBZoomableImageView *imageView in self.zoomableImageViews) {
        [imageView setBackgroundColor:backgroundColor];
    }
}

- (NSUInteger)currentPage {
    CGFloat offset = self.container.contentOffset.x;
    CGFloat pageWidth = self.container.layer.bounds.size.width;
    NSInteger page = roundf(offset / pageWidth);
    return page;
}

- (void)setCurrentPage:(NSUInteger)currentPage {
    self.container.contentOffset = CGPointMake(currentPage * self.container.bounds.size.width, self.container.contentOffset.y);
}

- (NSArray *)images {
    return [NSArray arrayWithArray:_images];
}

#pragma mark -

- (void)addImage:(UIImage *)image {
    [self insertImage:image atIndex:self.images.count];
}

- (void)insertImage:(UIImage *)image atIndex:(NSUInteger)index {
    NSAssert(image, @"Cannot add nil image");
    NSAssert(index <= self.images.count, @"Index is out of range");
    [_images insertObject:image atIndex:index];
    [self insertZoomableImageViewForImage:image atIndex:index];
}

- (void)insertZoomableImageViewForImage:(UIImage *)image atIndex:(NSUInteger)index {
    KBZoomableImageView *imageView = [[KBZoomableImageView alloc] initWithImage:image];
    imageView.showsScrollIndicator = YES;
    imageView.backgroundColor = self.backgroundColor;
    [self.container addSubview:imageView];
    [self.zoomableImageViews insertObject:imageView atIndex:index];
    
    [self layoutImageViewAtIndex:(NSUInteger)index];
}

- (void)removeImage:(UIImage *)image {
    NSUInteger index = [self.images indexOfObject:image];
    [self deleteImageAtIndex:index];
}

- (void)deleteImageAtIndex:(NSUInteger)index {
    KBZoomableImageView *imageView = self.zoomableImageViews[index];
    [imageView removeFromSuperview];
    [self layoutImageViewAtIndex:index];
    [self.zoomableImageViews removeObject:imageView];
    [_images removeObjectAtIndex:index];
}

- (void)layoutImageViewAtIndex:(NSUInteger)index {
    CGFloat contentWidth = self.zoomableImageViews.count * self.container.bounds.size.width;
    CGFloat contentHeight = self.container.bounds.size.height;
    self.container.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    for (NSUInteger i = index; i < self.zoomableImageViews.count; i++) {
        KBZoomableImageView *imageView = self.zoomableImageViews[i];
        CGFloat imageViewWidth = self.bounds.size.width;
        CGFloat imageViewHeight = self.bounds.size.height;
        CGFloat imageViewX = i * imageViewWidth;
        CGFloat imageViewY = 0;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    }
}

#pragma mark - Scroll view's delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UIImage *image = self.images[self.currentPage];
    if ([self.delegate respondsToSelector:@selector(imageScrollView:didScrollToImage:atIndex:)]) {
        [self.delegate imageScrollView:self didScrollToImage:image atIndex:self.currentPage];
    }
}

@end
