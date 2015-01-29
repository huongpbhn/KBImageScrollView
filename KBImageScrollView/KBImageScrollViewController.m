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

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageScrollView = [[KBImageScrollView alloc] init];
        self.imageScrollView.delegate = self;
        [self.view addSubview:self.imageScrollView];
    }
    return self;
}

#pragma mark - View controller's life-cycle

- (void)loadView {
    [super loadView];
    self.imageScrollView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Interface orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    self.imageScrollView.frame = CGRectMake(0, 0, size.width, size.height);
}

#pragma mark - Accessors

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self.view setBackgroundColor:backgroundColor];
    [self.imageScrollView setBackgroundColor:backgroundColor];
}

- (UIColor *)backgroundColor {
    return self.view.backgroundColor;
}

#pragma mark -

- (void)addImage:(UIImage *)image {
    [self.imageScrollView addImage:image];
}

- (void)removeImage:(UIImage *)image {
    [self.imageScrollView removeImage:image];
}

- (void)insertImage:(UIImage *)image atIndex:(NSUInteger)index {
    [self.imageScrollView insertImage:image atIndex:index];
}

- (void)deleteImageAtIndex:(NSUInteger)index {
    [self.imageScrollView deleteImageAtIndex:index];
}

#pragma mark - KBImageScrollView's delegate methods

- (void)imageScrollView:(KBImageScrollView *)imageScrollView didScrollToImage:(UIImage *)image atIndex:(NSUInteger)index {
    
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
