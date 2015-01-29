//
//  KBImageScrollViewController.m
//  KBImageScrollViewDemo
//
//  Created by Truong Minh Khoi on 1/28/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import "KBImageScrollViewController.h"
#import "KBImageScrollView.h"

@interface KBImageScrollViewController () <KBImageScrollViewDelegate>

@property (nonatomic, strong) KBImageScrollView *imageScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation KBImageScrollViewController

#pragma mark - Memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View controller's life-cycle

- (void)loadView {
    [super loadView];
    [self setupViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.pageControl sizeToFit];
    self.pageControl.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - self.pageControl.bounds.size.height/2);
    if (self.showPageControl) {
        self.imageScrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.pageControl.bounds.size.height);
    } else {
        self.imageScrollView.frame = self.view.bounds;
    }
}

- (void)setupViews {
    self.imageScrollView = [[KBImageScrollView alloc] init];
    self.imageScrollView.delegate = self;
    [self.view addSubview:self.imageScrollView];
    self.pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:self.pageControl];
}

#pragma mark - Accessors

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self.view setBackgroundColor:backgroundColor];
    [self.imageScrollView setBackgroundColor:backgroundColor];
}

- (UIColor *)backgroundColor {
    return self.view.backgroundColor;
}

- (BOOL)showPageControl {
    return !self.pageControl.hidden;
}

- (void)setShowPageControl:(BOOL)showPageControl {
    self.pageControl.hidden = !showPageControl;
    [self viewDidLayoutSubviews];
}

#pragma mark -

- (void)addImage:(UIImage *)image {
    [self.imageScrollView addImage:image];
    self.pageControl.numberOfPages = self.imageScrollView.images.count;
    self.pageControl.currentPage = self.imageScrollView.currentPage;
}

- (void)removeImage:(UIImage *)image {
    [self.imageScrollView removeImage:image];
    self.pageControl.numberOfPages = self.imageScrollView.images.count;
    self.pageControl.currentPage = self.imageScrollView.currentPage;
}

- (void)insertImage:(UIImage *)image atIndex:(NSUInteger)index {
    [self.imageScrollView insertImage:image atIndex:index];
    self.pageControl.numberOfPages = self.imageScrollView.images.count;
    self.pageControl.currentPage = self.imageScrollView.currentPage;
}

- (void)deleteImageAtIndex:(NSUInteger)index {
    [self.imageScrollView deleteImageAtIndex:index];
    self.pageControl.numberOfPages = self.imageScrollView.images.count;
    self.pageControl.currentPage = self.imageScrollView.currentPage;
}

#pragma mark - KBImageScrollView's delegate methods

- (void)imageScrollView:(KBImageScrollView *)imageScrollView didScrollToImage:(UIImage *)image atIndex:(NSUInteger)index {
    [self.pageControl setCurrentPage:index];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
