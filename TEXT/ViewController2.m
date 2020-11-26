//
//  ViewController.m
//  TEXT
//
//  Created by 刘博 on 2019/10/17.
//  Copyright © 2019 刘博. All rights reserved.
//

#import "ViewController2.h"
#import "ScrolllView.h"
#import "ScrolllView.h"
#define VVIs_iPhoneXSeries \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
\
}\
(isPhoneX);})\


@interface ViewController2 ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (strong, nonatomic) dispatch_queue_t launchQueue;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
   // BOOL isIphonex = VVIs_iPhoneXSeries;
   // self.view.backgroundColor = [UIColor whiteColor];
//    if (@available(iOS 11.0, *)) {
//        UIWindow *window = UIApplication.sharedApplication.keyWindow;
//        window = UIApplication.sharedApplication.keyWindow;
//        CGFloat topPadding = window.safeAreaInsets.top;
//        CGFloat bottomPadding = window.safeAreaInsets.bottom;
//        NSLog(@"距离底部距离底部%lf",bottomPadding);
//    }
    
//    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
//    scrollview.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:scrollview];
//    NSArray *title = @[@"1",@"2",@"3",@"4"];
//    for (int i = 0; i < 4; i ++) {
//        UIButton *bu  = [UIButton buttonWithType:UIButtonTypeCustom];
//        bu.frame = CGRectMake(40 * i , 0, 30, 40);
//        [bu setTitle:title[i] forState:UIControlStateNormal];
//        bu.titleLabel.font = [UIFont systemFontOfSize:14];
//        [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        bu.backgroundColor = [UIColor cyanColor];
//        [scrollview addSubview:bu];
//    }
//    //scrollview.transform = CGAffineTransformMakeRotation(M_PI);
//    for (UIButton *button in scrollview.subviews) {
//        button.transform = CGAffineTransformMakeRotation(M_PI);
//    }
//    scrollview.transform = CGAffineTransformRotate(scrollview.transform, M_PI);
//    scrollview.layer.transform = CATransform3DIsAffine(<#CATransform3D t#>)
////
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    button.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:button];
//    ScrolllView *vc = [[ScrolllView alloc] init];
//    BOOL a =  vc.a;
//    BOOL s = vc.isAAA;
    
//    CGFloat bottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
//    NSLog(@"距离底部%f",bottom);
//    ScrolllView *view = [[ScrolllView alloc] initWithFrame:CGRectMake(0, 200, 300, 100)];
//    [self.view addSubview:view];
//
//    NSString *titl = @"qweroiyqwr 346981734  asdkfhasdfk  asfdasf";
//    titl = [titl stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString *contentStr = @"sahfihasdkljfhaslkjfhlaksjdfhlakjsfhdlajsdhfljaksdhfljkashdfsize=\"42px\"qwerqwer";
//    NSMutableAttributedString *attrStr;
//    NSString * regExpStr = @"size=\"[0-9]{1,2}px\"";
//            NSString * replacement = @"size=\"3px\"";
//    NSError *error = nil;
//            // 创建 NSRegularExpression 对象,匹配 正则表达式
//            NSRegularExpression *regExp =
//            [[NSRegularExpression alloc] initWithPattern:regExpStr
//                                                 options:NSRegularExpressionCaseInsensitive
//                                                   error:nil];
//
//            contentStr = [regExp stringByReplacingMatchesInString:contentStr
//                                                             options:NSMatchingReportProgress
//                                                               range:NSMakeRange(0, contentStr.length)
//                                                        withTemplate:replacement];
//
//            attrStr = [[NSAttributedString alloc] initWithData:[contentStr dataUsingEncoding:NSUnicodeStringEncoding]
//                                                       options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
//                                            documentAttributes:nil
//                                                         error:&error];
//
//    UIImageView *img  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 200, 38)];
//   // img.image = [[UIImage imageNamed:@"product_detail_spike_bubble"] resizableImageWithCapInsets:UIEdgeInsetsMake(1,30, 15, 5)];
//    img.image = [[UIImage imageNamed:@"product_detail_spike_bubble"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,30, 0, 5) resizingMode:UIImageResizingModeStretch];;
//
//   // [self.view addSubview:img];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    [button setImage:[UIImage imageNamed:@"product_detail_spike_bubble"] forState:UIControlStateNormal];
//    [self.view addSubview:button];
    
//    CGFloat H = .2;
//    NSString *ST = [NSString stringWithFormat:@"%.3f",H];
//    NSLog(@"%@",ST);
//    NSArray *ARRA  = @[@"1",@"2",@"3"];
//    NSArray *BB = @[@"1",@"2",@"3"];
//    NSLog(@"第一个第一个而第一个%d",ARRA == BB);
//    NSLog(@"第二个第二个第二个第二个%d",[ARRA isEqualToArray:BB]);
    // Do any additional setup after loading the view.
   // NSLog(@"%f",[self roundFloat:5.55
     //            ；
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:button];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    [button addTarget:self action:@selector(click ) forControlEvents:UIControlEventTouchUpInside];
//    [button addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
//    [button addTarget:self action:@selector(kkk ) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor redColor];
    
//    NSArray *array = @[@1,@8,@4,@5,@2,@3];
//       NSMutableArray *mutableArray1 = [NSMutableArray arrayWithArray:array];
//       NSMutableArray *mutableArray2 = [NSMutableArray arrayWithArray:array];
//       NSMutableArray *mutableArray3 = [NSMutableArray arrayWithArray:array];
      // NSArray *stringArray = @[@"name",@"age",@"sex",@"height",@"weight",@"namy"];
//       NSArray *mixArray = @[@9,@8,@1,@29,@40,@5,@100,@89];
//     //  NSArray *numArray = @[@"1",@"8",@"4",@"5",@"2",@"3"];
//
//       NSArray *mixArray1 = [mixArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
//           return obj1.integerValue < obj2.integerValue;
//       }];
       
//      NSArray *numArray1 = [stringArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//          if ([obj2 isEqualToString:@"name"]) {
//              return NSOrderedAscending;
//          }
//          return NSOrderedDescending;
//          NSLog(@"%@ %@ %d",obj1,obj2, [obj1 compare:obj2]);
//          return [obj1 compare:obj2];
//
          // return NSOrderedAscending;
  //     }];
  //  NSLog(@"%@ \n %@",stringArray,numArray1);
   // NSLog(@"%@\n  %@",mixArray,mixArray1);
    dispatch_queue_t queue = dispatch_queue_create("com.dispatch.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
      dispatch_group_t group = dispatch_group_create();
      dispatch_async(queue, ^{
          NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
          NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
              // 请求完成，可以通知界面刷新界面等操作
              NSLog(@"第一步网络请求完成");
              // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
              dispatch_semaphore_signal(semaphore);
              
              
          }];
          [task resume];
          // 以下还要进行一些其他的耗时操作
         
          
      });
    NSLog(@"耗时操作继续进行");
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    });
             
    
    return;
      self.launchQueue = dispatch_queue_create("LaunchQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(self.launchQueue, ^{
          NSLog(@"11111");
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"一一一一内内内");
            });
       
      });
      
      dispatch_async(self.launchQueue, ^{
          NSLog(@"22222");

          //dispatch_semaphore_wait(self.launchSemaphore, DISPATCH_TIME_FOREVER);
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
              NSLog(@"二内二内二内");

              // 拷贝工程中rn的base模块
              
          });
      });
      
      dispatch_async(self.launchQueue, ^{
          NSLog(@"33333");

          //dispatch_semaphore_wait(self.launchSemaphore, DISPATCH_TIME_FOREVER);
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
              NSLog(@"三内三内是哪内");

              //dispatch_semaphore_signal(self.launchSemaphore);
          });
      });
      
      dispatch_async(self.launchQueue, ^{
          NSLog(@"444444");
          //dispatch_semaphore_wait(self.launchSemaphore, DISPATCH_TIME_FOREVER);
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              NSLog(@"寺内寺内寺内");

          });
      });
      
      dispatch_async(self.launchQueue, ^{
          NSLog(@"55555");
          //dispatch_semaphore_wait(self.launchSemaphore, DISPATCH_TIME_FOREVER);
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              NSLog(@"屋内屋内屋内");

          });
      });
      
      dispatch_async(self.launchQueue, ^{
          NSLog(@"666666");
          //dispatch_semaphore_wait(self.launchSemaphore, DISPATCH_TIME_FOREVER);
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              NSLog(@"刘内刘内");
          });
      });
}

- (void)click:(UIButton *)button
{
    CATransition *animation = [CATransition animation];
      animation.duration = 1.2f ;
      animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionFade;
      animation.type = @"cube";
   /// animation.type = kCATransitionReveal;
    //animation.type = kCATransitionFromLeft;
    animation.subtype = kCATransitionFromBottom;
    //animation.subtype = kCATransitionReveal;
      
      [button.layer addAnimation:animation forKey:@"animationID"];
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = [UIColor cyanColor];
    } else {
        button.backgroundColor = [UIColor greenColor];
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        CGFloat topPadding = window.safeAreaInsets.top;
        CGFloat bottomPadding = window.safeAreaInsets.bottom;
        NSLog(@"距离底部距离底部%lf", bottomPadding);
    }
}
- (void)refresh
{
    NSLog(@"二二二二");
}

- (void)kkk
{
    NSLog(@"kkkkkk");
}

-(float)roundFloat:(float)price{
    return (floorf(price*100 + 0.5))/100;
}
@end

