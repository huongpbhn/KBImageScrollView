//
//  ViewController.m
//  KBImageScrollViewDemo
//
//  Created by Truong Minh Khoi on 1/27/15.
//  Copyright (c) 2015 Khoi Truong Minh. All rights reserved.
//

#import "ViewController.h"
#import "KBImageScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    KBImageScrollViewController *imageScrollViewController = [[KBImageScrollViewController alloc] init];
    imageScrollViewController.backgroundColor = [UIColor blackColor];
    for (NSUInteger i = 0; i < 6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        [imageScrollViewController addImage:image];
    }
    
    [imageScrollViewController deleteImageAtIndex:1];
    [imageScrollViewController insertImage:[UIImage imageNamed:@"6.jpg"] atIndex:1];
    [imageScrollViewController insertImage:[UIImage imageNamed:@"7.jpg"] atIndex:3];
    
    [self presentViewController:imageScrollViewController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
