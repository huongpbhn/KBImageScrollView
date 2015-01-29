//
//  KBImageScrollViewController.m
//  KBImageScrollViewDemo
//
//  Created by Truong Minh Khoi on 1/28/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import "KBImageScrollViewController.h"
#import "KBImageScrollView.h"

@interface KBImageScrollViewController ()

@property (nonatomic, strong) KBImageScrollView *imageScrollView;

@end

@implementation KBImageScrollViewController

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
        [self.view addSubview:self.imageScrollView];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.imageScrollView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self.view setBackgroundColor:backgroundColor];
    [self.imageScrollView setBackgroundColor:backgroundColor];
}

- (UIColor *)backgroundColor {
    return self.view.backgroundColor;
}

- (void)addImage:(UIImage *)image {
    [self.imageScrollView addImage:image];
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
