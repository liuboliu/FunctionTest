//
//  ViewController8.m
//  TEXT
//
//  Created by 刘博 on 2020/12/2.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewController8.h"
#import <MJRefresh/MJRefresh.h>

@interface ViewController8 ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, assign) NSInteger kkk;

@end

@implementation ViewController8

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *contet = @"JJJJJJJJkkuuuuuuu";
    contet = [contet stringByReplacingOccurrencesOfString:@"kK" withString:@"oo" options:NSCaseInsensitiveSearch range:NSMakeRange(0, contet.length)];
    NSLog(@"哈哈哈哈%@",contet);
//    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 80, 200, 300)];
//    [self.view addSubview:scroll];
//    scroll.backgroundColor = [UIColor redColor];
//    scroll.contentSize = CGSizeMake(200, 0);
//    scroll.contentOffset = CGPointMake(0, -300);
//    scroll.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//shangsasahshasss
//    }];
//    [scroll.mj_header beginRefreshing];
//
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton_screen_dark@3x" ofType:@"jpg"];
//    imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton@3x" ofType:@"jpg"];
//    NSURL *url = [NSURL fileURLWithPath:imagePath];
//    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//    CGImageSourceRef imageref = CGImageSourceCreateWithURL((__bridge CFURLRef)url, NULL);
//    CFDictionaryRef property = CGImageSourceCopyPropertiesAtIndex(imageref, 0, NULL);
//    CFDictionaryRef options = (__bridge CFDictionaryRef)@{
//            (id)kCGImageSourceCreateThumbnailFromImageIfAbsent:@(YES),
//            (id)kCGImageSourceThumbnailMaxPixelSize:@100,   // 最大像素，如果设置很小就不清楚
//            (id)kCGImageSourceShouldCache:@YES
//        };
//    CGImageRef imageref2 = CGImageSourceCreateThumbnailAtIndex(imageref, 0, options);
//    UIImage *image2 = [UIImage imageWithCGImage:imageref2];
//    CGImageRelease(imageref2);
//      CFRelease(imageref);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width, self.view.bounds.size.width,   self.view.bounds.size.height - self.view.bounds.size.width)];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
    self.imgView = imageView;
  // imageView.image = image2;
//    imageView.image = image;
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(kkk1) forControlEvents:UIControlEventTouchUpInside];
//  

    //imageView.image = aImage;

    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event

{
    [self kkk1];
}

- (void)kkk1
{
//    self.kkk ++;
//    if (self.kkk % 2) {
       // [self test1];
//    } else {
        [self test2];
//    }
//    [self test3];
}

- (void)test1
{
    // NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton_screen_dark@3x" ofType:@"jpg"];
     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton@3x" ofType:@"jpg"];
 //    imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
     UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
     self.imgView.image = img;
}

- (void)test2
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton_screen_dark@3x" ofType:@"jpg"];
    imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton@3x" ofType:@"jpg"];
    //    imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    CGSize size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - self.view.bounds.size.width);
    CGSize cropSize;
    cropSize.width = img.size.width;
    cropSize.height = img.size.width * size.height / size.width;
    CGRect cropRect = CGRectMake(0, 0, (cropSize.width * img.scale), (cropSize.height * img.scale));
    
    UIGraphicsImageRendererFormat *fmtt = [[UIGraphicsImageRendererFormat alloc] init];
    fmtt.scale = 1;
    fmtt.opaque = NO;
    if (@available(iOS 12.0, *)) {
        fmtt.preferredRange = UIGraphicsImageRendererFormatRangeExtended;
    } else {
        // Fallback on earlier versions
    }
    
    UIImage *aImage;
    @autoreleasepool {
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:cropRect.size format:fmtt];
        aImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            [img drawInRect:CGRectMake(0, 0, img.size.width*img.scale, img.size.height*img.scale)];
        }];
    }
    self.imgView.image = aImage;
}

- (void)test3
{
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton_screen_dark@3x" ofType:@"jpg"];
        imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton@3x" ofType:@"jpg"];
        NSURL *url = [NSURL fileURLWithPath:imagePath];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        CGImageSourceRef imageref = CGImageSourceCreateWithURL((__bridge CFURLRef)url, NULL);
        CFDictionaryRef property = CGImageSourceCopyPropertiesAtIndex(imageref, 0, NULL);
        CFDictionaryRef options = (__bridge CFDictionaryRef)@{
                (id)kCGImageSourceCreateThumbnailFromImageIfAbsent:@(YES),
                (id)kCGImageSourceThumbnailMaxPixelSize:@100,   // 最大像素，如果设置很小就不清楚
                (id)kCGImageSourceShouldCache:@YES
            };
        CGImageRef imageref2 = CGImageSourceCreateThumbnailAtIndex(imageref, 0, options);
        UIImage *image2 = [UIImage imageWithCGImage:imageref2];
        CGImageRelease(imageref2);
          CFRelease(imageref);
    self.imgView.image = image2;

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
