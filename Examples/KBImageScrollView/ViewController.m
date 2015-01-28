//
//  ViewController.m
//  KBImageScrollViewDemo
//
//  Created by Truong Minh Khoi on 1/27/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import "ViewController.h"
#import "KBImageScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KBImageScrollView *imageScrollView = [[KBImageScrollView alloc] init];
    imageScrollView.backgroundColor = [UIColor blackColor];
    imageScrollView.frame = CGRectMake(0, 64, 320, 400);
    for (NSUInteger i = 0; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        [imageScrollView addImage:image];
    }
    
    [self.view addSubview:imageScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
