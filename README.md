#KBImageScrollView

https://www.youtube.com/watch?v=Kl6DuWyrb8M

##Create a KBImageScrollViewController:
```objective-c
  KBImageScrollViewController *imageScrollViewController = [[KBImageScrollViewController alloc] init];
  UIImage *image = [UIImage imageNamed:@"image.png"];
  [imageScrollViewController addImage:image];
```

###Insert an image:
```objective-c
  [imageScrollViewController insertImage:[UIImage imageNamed:@"image1.jpg"] atIndex:1];
```

###Delete an image:
```objective-c
  [imageScrollViewController deleteImageAtIndex:1];
```

##Create a KBImageScrollView:
```objective-c
  KBImageScrollView *imageScrollView = [[KBImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
  [self.view addSubview:self.imageScrollView];
  [imageScrollViewController addImage:[UIImage imageNamed:@"image.png"]];
```

If you find any issue, or have questions, please create an issue on GitHub or email me: khoi.truongminh@gmail.com
Thank you!
