//
//  ViewController.m
//  TEXT
//
//  Created by 刘博 on 2020/4/2.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "NSTimer+_9.h"


@interface ViewController ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WKWebView *wk_WebView;

@property (nonatomic, copy) NSString *contentTitle;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic) dispatch_queue_t queue;

@end

@implementation ViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.name = @"a";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"ff";
//    [self requestWithCompletion:^(NSInteger num) {
//        return 4;
//    }];;
//    self.contentTitle = @"标题标题标题标题";
//    __weak typeof(self) weakSelf = self;
//   self.timer =  [NSTimer eoc_scheduledTimerWithTimeInterval:1 block:^{
//        NSLog(@"%@",weakSelf.contentTitle);
//    } repeats:YES];
//    NSInteger (^goToReveiw)(void) = ^ NSInteger (void){
//           return 9;
//       };
//    int (^block)(NSInteger) = ^  (NSInteger num) {
//        NSLog(@"树龄数量数量%ld",num);
//        return 4;
//    };
//    NSInteger num = goToReveiw();
//    NSLog(@"这里的数量%ld",num);
//    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
//        self.view.backgroundColor = [UIColor redColor];
//    }
//    NSMutableArray *array = [NSMutableArray array];
//    CGFloat i =   0.5/[UIScreen mainScreen].scale;
//    NSLog(@"大熊啊大熊啊大小大小%f",i );
   // [array addObjectsFromArray:@{}];
//    NSString * path = [[NSBundle mainBundle] pathForResource:@"newuser" ofType:@"js"];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    NSString *jscode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    self.jsContext = [[JSContext alloc] init];
//    [self.jsContext evaluateScript:jscode];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 100, 200, 100);
//    button.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    self.data  =  @[@"1",@"2",@"3"];
//    [self.array addObject:@"4"];
//    //[self createWebView];
//    [self createwk_WebView];
    // Do any additional setup after loading the view.
}

- (void)createWebView {
    // js配置
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    // WKWebView的配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    // 显示WKWebView
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 400) configuration:configuration];
    self.webView.UIDelegate = self; // 设置WKUIDelegate代理
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    configuration.userContentController = userContentController;
  [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"printLog"];//js打印事件
  //注入js的代码，就相当于重写了js的printLog方法，在printLog方法中去调用原生方法
// function 后面的方法名跟js代码中的方法名要一致
    NSString *printContent = @"window.webkit.messageHandlers.printLog.postMessage({'3ui435u':'ZHELI ZHELI ZHELI ZHELI '})";
    //WKUserScript *userScript = [[WKUserScript alloc] initWithSource:printContent injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    //[self.webView.configuration.userContentController addUserScript:userScript];
    [self.webView evaluateJavaScript:printContent completionHandler:^(id _Nullable JJ, NSError * _Nullable error) {
        
    }];
}

- (void)createwk_WebView {
    if (!_wk_WebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = [[WKPreferences alloc]init];
        config.userContentController = [[WKUserContentController alloc]init];
        // 注入JS对象名称senderModel，当JS通过senderModel来调用时，我们可以在WKScriptMessageHandler代理中接收到
//        [config.userContentController addScriptMessageHandler:self name:@"doShare"];
        NSString * btnId = @"index-bn";//测试-百度一下按钮id
        [config.userContentController addScriptMessageHandler:self name:@"backHomeClick_tes"];
        //给 function backHomeClick(){}注入window.webkit.messageHandlers.(messagename).postMessage
        NSString *scriptStr = [NSString stringWithFormat:@"function backHomeClick_(){window.webkit.messageHandlers.%@.postMessage(null);}(function(){var btn=document.getElementById(\"%@\");btn.addEventListener('click',backHomeClick_,false);}());", @"backHomeClick_tes",btnId];
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:scriptStr injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:userScript];
        _wk_WebView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
        _wk_WebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _wk_WebView.navigationDelegate = self;
        _wk_WebView.UIDelegate = self;
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_wk_WebView loadRequest:request];
        [self.view addSubview:self.wk_WebView];
    }
}

//js调用打印方法时就会调用此方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",message);
    NSLog(@"%@",message.body);
    NSLog(@"%@",message.name);
    if ([@"printLog" isEqualToString:message.name]) {
        [self printLog:@"jjj"];
    }
}

- (void)requestWithCompletion:(int (^)(NSInteger ))completion
{
    if (completion) {
      NSInteger ff =  completion(4);
        NSLog(@"哈哈哈哈哈%ld",ff);
    }
}

- (void) printLog:(NSString *)hhh {
  //重新实现js方法
}

- (NSMutableArray *)array
{
    NSMutableArray *array = [self mutableArrayValueForKey:@"data"];
    return array;
}
- (void)click
{
     if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
           self.view.backgroundColor = [UIColor redColor];
       }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    [self.timer invalidate];
}

@end
