//
//  ViewController7.m
//  TEXT
//
//  Created by 刘博 on 2020/11/26.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewController7.h"

@interface ViewController7 ()

@property (weak, nonatomic)  UIStackView *s2;
@property (weak, nonatomic)  UIStackView *s3;
@property (weak, nonatomic)  UIStackView *s4;


@end

@implementation ViewController7

- (void)viewDidLoad {
    //    [self configS3];
        
    //    [self.view layoutIfNeeded];
    //    [self printSubviews:self.s4];
    //    [self printSubviews:self.s3];

    //    [self test];·
        
        
        //png8 rgb
        //像素点 -> 颜色 -> ffffffff -> 1111 1111 1111 1111
        
        //png24 rgb
        //像素点 -> 颜色 -> ffffffff -> 1111111111111111 1111111111111111 1111111111111111
        
        //png32 rgba
        //像素点 -> 颜色 -> ffffffff -> 1111111111111111 1111111111111111 1111111111111111 1111111111111111
        //4byts
        //1125*3180*4 -> 位图(bitmap) -> 13.6M -> 压缩算法 -> 无损压缩 -> png
        //                                                  有损压缩 -> jpg
        
        //加载png(99kb) -> 读取到内存(99kb) -> 解压缩(13.6M) -> 还原成bitmap(13.6M) -> 渲染
        [self testImgMemory];
        //[self testImgMemory];
    }

    - (void)testNumber
    {
    //    [self testIsNumber];
        
    //    [self testShowUnsignedShortMax];
    //    [self testCompact];
        
    //    [self testLocal];
        
    //    [self testShowFloat];
        
    //    [self testAdd];
        
    //    [self testDividingBy];
    //    [self testDividingByError];
    }

    - (void)testImgMemory
    {
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        //[self testImgContentFile]; //25M
        [self testImgRenderer]; //11.8M
    //    [self testImgRendererWithSmallSize]; //13.7M
        
    //    [self testClearImgContentFile]; //25.2M
    //    [self testClearImgNamed]; //25.1M
    //    [self testClearImgRenderer]; //11.7M
    //    [self testClearImgRendererWithSmallSize]; //13.8M
    }

    #pragma mark - test
    - (void)testIsNumber
    {
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"AA"]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"aa"]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"a.1"]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"......1"]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"0..1"]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"0.1.1"]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"00.1"]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@"1."]];
        [self checkIsNum:[[NSDecimalNumber alloc] initWithString:@".1"]];
        
        
        
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"......1"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"0..1"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"0.1.1"]];
    }

    - (void)testShowFloat
    {
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"1232.22"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"12322.2"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"12322.2"]];
    }

    - (void)testShowUnsignedShortMax
    {
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"65534"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"65535"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"65536"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"65537"]];
        [self logNum:[[NSDecimalNumber alloc] initWithString:@"65538"]];
    }

    - (void)testMaximumDecimalNumber
    {
        NSString *maxValue = @"3402823669209384634633746074317682114550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        NSDecimalNumber *maxNum = [[NSDecimalNumber alloc] initWithString:maxValue];
        if ([maxNum isEqual:[NSDecimalNumber maximumDecimalNumber]]) {
            [self logNum:maxNum];
        } else {
            NSAssert(NO, @"value not same");
        }
    }

    - (void)testMaxValueWithoutExponent
    {
        NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:@"340282366920938463463374607431768211455"];
        [self logNum:num1];
        
        NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"340282366920938463463374607431768211456"];
        [self logNum:num2];
    }

    - (void)testOutOfPrecision
    {
        NSDecimalNumber *num0 = [[NSDecimalNumber alloc] initWithString:@"655380000000000000000000000000000000000"];
        NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:@"655380000000000000000000000000000000001"];
        NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"655380000000000000000000000000000000002"];
        if ([num0 isEqual:num1]) {
            NSLog(@"=== same");
        } else {
            NSLog(@"=== not same");
        }
        
        if ([num2 isEqual:num1]) {
            NSLog(@"=== same");
        } else {
            NSLog(@"=== not same");
        }
        
        [self logNum:num0];
        [self logNum:num1];
        [self logNum:num2];
    }

    - (void)testCompact
    {
        NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:@"655380000000000000000000000000000000000000000000001"];
        NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"655380000000000000000000000000000000000000000000002"];
        
        [self logNum:num1];
        [self logNum:num2];
        
        NSDecimal d1 = num1.decimalValue;
        NSDecimal d2 = num2.decimalValue;
        
        NSDecimalCompact(&d1);
        NSDecimalCompact(&d2);
        
        [self logNum:num1];
        [self logNum:num2];
        
        num1 = [[NSDecimalNumber alloc] initWithDecimal:d1];
        num2 = [[NSDecimalNumber alloc] initWithDecimal:d2];

        [self logNum:num1];
        [self logNum:num2];
    }

    - (void)testLocal
    {
        //土耳其语 -土耳其
        NSLog(@"testlocal: %@", [[[NSDecimalNumber alloc] initWithString:@"2221232.22"] descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"tr-TR"]]);
        //阿拉伯语 - 沙特阿拉伯
        NSLog(@"testlocal: %@", [[[NSDecimalNumber alloc] initWithString:@"2221232.22"] descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"ar-SA"]]);
        //阿拉伯语 -伊拉克
        NSLog(@"testlocal: %@", [[[NSDecimalNumber alloc] initWithString:@"2221232.22"] descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"ar-IQ"]]);
        //西班牙 - 哥斯达黎加
        NSLog(@"testlocal: %@", [[[NSDecimalNumber alloc] initWithString:@"2221232.22"] descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"es-CR"]]);
        //蒙古 -蒙古
        NSLog(@"testlocal: %@", [[[NSDecimalNumber alloc] initWithString:@"2221232.22"] descriptionWithLocale:[NSLocale localeWithLocaleIdentifier:@"mn-MN"]]);

    }

    - (void)testScale
    {
        [self testScale:[NSDecimalNumber decimalNumberWithString:@"1111.223"]];
        [self testScale:[NSDecimalNumber decimalNumberWithString:@"1111.225"]];
        [self testScale:[NSDecimalNumber decimalNumberWithString:@"1111.226"]];
        [self testScale:[NSDecimalNumber decimalNumberWithString:@"1111.224999"]];
        [self testScale:[NSDecimalNumber decimalNumberWithString:@"1111.225001"]];
    }

    - (void)testScale:(NSDecimalNumber *)number
    {
        NSDecimalNumber *num = [number decimalNumberByRoundingAccordingToBehavior:[self testHandle]];
      
        [self logNum:number];
        [self logNum:num];
    }

    - (void)testAdd
    {
        NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:@"1.2231"];
        NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"1.2219"];
        
        NSDecimalNumber *r1 = [num1 decimalNumberByAdding:num2];
        NSDecimalNumber *r2 = [num1 decimalNumberByAdding:num2 withBehavior:[self testHandle]];

        [self logNum:r1];
        [self logNum:r2];
    }

    - (void)testDividingBy
    {
        NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:@"1.2231"];
        NSDecimalNumber *num2 = [[NSDecimalNumber alloc] initWithString:@"1.2219"];
        
        NSDecimalNumber *r1 = [num1 decimalNumberByDividingBy:num2];
        NSDecimalNumber *r2 = [num1 decimalNumberByDividingBy:num2 withBehavior:[self testHandle]];

        [self logNum:r1];
        [self logNum:r2];
    }

    - (void)testDividingByError
    {
        NSDecimalNumber *num1 = [[NSDecimalNumber alloc] initWithString:@"1.2231"];
        NSDecimalNumber *num2 = [NSDecimalNumber zero];
        
        NSDecimalNumberHandler *handle2 = [self testHandle2];
        NSDecimalNumber *r1 = [num1 decimalNumberByDividingBy:num2 withBehavior:handle2];
        [self logNum:r1];
        
    //    NSDecimalNumber *handle = [self testHandle];
    //    NSDecimalNumber *r2 = [num1 decimalNumberByDividingBy:num2 withBehavior:handle];
    //    [self logNum:r2];
    }

    #pragma mark - Utils
    - (void)checkIsNum:(NSDecimalNumber *)num
    {
        NSDecimal decimal = num.decimalValue;
        if (NSDecimalIsNotANumber(&decimal)) {
            NSLog(@"not a number");
        } else {
            NSLog(@"is a numer");
        }
        
        
        if ([num isEqual:[NSDecimalNumber notANumber]]) {
            
        }
    }


    - (void)logNum:(NSDecimalNumber *)num
    {
        NSLog(@"   ");
        NSLog(@"   ");
        NSLog(@"----------------- num log start -----------------");
        
    //    typedef struct {
    //        signed   int _exponent:8;
    //        unsigned int _length:4;     // length == 0 && isNegative -> NaN
    //        unsigned int _isNegative:1;
    //        unsigned int _isCompact:1;
    //        unsigned int _reserved:18;
    //        unsigned short _mantissa[8];
    //    } NSDecimal;

        
        
        NSLog(@"num is: %@", num);
        for (int i = 0 ; i < 8 ; i++) {
            NSLog(@"尾数%@: %@", @(i), @(num.decimalValue._mantissa[i]));
        }
        NSLog(@"指数: %i", num.decimalValue._exponent); //10^n
        NSLog(@"长度: %i", num.decimalValue._length);
        NSLog(@"负数: %i", num.decimalValue._isNegative);
        NSLog(@"压缩: %i", num.decimalValue._isCompact);
        NSLog(@"保留: %i", num.decimalValue._reserved);
        
        
        //压缩：Formats number so that calculations using it will take up as little memory as possible. All the NSDecimal... arithmetic functions expect compact NSDecimal arguments.
        //格式化数字，以便使用它进行的计算将占用尽可能少的内存。 所有NSDecimal ...算术函数都希望使用压缩的NSDecimal参数。
        
        NSLog(@"----------------- num log end -----------------");
        NSLog(@"   ");
        NSLog(@"   ");
    }

    - (NSDecimalNumberHandler *)testHandle
    {
        NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                 scale:2
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
        
        return handler;
    }

    - (NSDecimalNumberHandler *)testHandle2
    {
        NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                 scale:2
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:NO];
        
        return handler;
    }


    #pragma mark - stack view
    - (void)printSubviews:(UIView *)view
    {
        if (!view) {
            return;
        }
        
        if (!view.subviews.count) {
            NSLog(@"------- %f", view.center.x);
            NSLog(@"------- %@", view);
            return;
        }
        
        for (UIView *subview in view.subviews) {
            [self printSubviews:subview];
        }
    }

    - (void)configS3
    {
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
            view.backgroundColor = [UIColor redColor];
            [self.s3 addArrangedSubview:view];
        }
        
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 0, 40, 60)];
            view.backgroundColor = [UIColor blueColor];
            [self.s3 addArrangedSubview:view];
        }

        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80, 0, 40, 60)];
            view.backgroundColor = [UIColor purpleColor];
            [self.s3 addArrangedSubview:view];
        }

        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(120, 0, 40, 60)];
            view.backgroundColor = [UIColor greenColor];
            [self.s3 addArrangedSubview:view];
        }
    }

    #pragma mark - img memory
    - (void)testImgContentFile
    {
        NSString *imagePath;
        imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton_screen" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];

        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        iv.image = img;
        [self.view addSubview:iv];
    }

    - (void)testImgRenderer
    {
        NSString *imagePath;
        imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton_screen" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];

        CGSize size = UIScreen.mainScreen.bounds.size;
        CGSize cropSize;
        cropSize.width = img.size.width;
        cropSize.height = img.size.width * size.height / size.width;
        CGRect cropRect = CGRectMake(0, 0, (cropSize.width * img.scale), (cropSize.height * img.scale));
        
        UIGraphicsImageRendererFormat *fmtt = [[UIGraphicsImageRendererFormat alloc] init];
        fmtt.scale = 1;
        fmtt.opaque = NO;
        fmtt.preferredRange = UIGraphicsImageRendererFormatRangeExtended;
        
        UIImage *aImage;
        @autoreleasepool {
            UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:cropRect.size format:fmtt];
            aImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                [img drawInRect:CGRectMake(0, 0, img.size.width*img.scale, img.size.height*img.scale)];
            }];
        }
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        iv.image = aImage;
        [self.view addSubview:iv];
    }

    - (void)testImgRendererWithSmallSize
    {
        NSString *imagePath;
        imagePath = [[NSBundle mainBundle] pathForResource:@"product_detail_skeleton_screen" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];

        CGSize size = UIScreen.mainScreen.bounds.size;
        CGSize cropSize;
        cropSize.width = img.size.width;
        cropSize.height = img.size.width * size.height / size.width;
        CGRect cropRect = CGRectMake(0, 0, (cropSize.width * img.scale), (cropSize.height * img.scale));
        
        UIGraphicsImageRendererFormat *fmtt = [[UIGraphicsImageRendererFormat alloc] init];
        fmtt.scale = 0.3;
        fmtt.opaque = NO;
        fmtt.preferredRange = UIGraphicsImageRendererFormatRangeExtended;
        
        UIImage *aImage;
        @autoreleasepool {
            UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:cropRect.size format:fmtt];
            aImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                [img drawInRect:CGRectMake(0, 0, img.size.width*img.scale, img.size.height*img.scale)];
            }];
        }
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        iv.image = aImage;
        [self.view addSubview:iv];
    }

    - (void)testClearImgNamed
    {
        UIImage *img = [UIImage imageNamed:@"1"];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        iv.image = img;
        [self.view addSubview:iv];
    }

    - (void)testClearImgContentFile
    {
        NSString *imagePath;
        imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];

        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        iv.image = img;
        [self.view addSubview:iv];
    }

    - (void)testClearImgRenderer
    {
        NSString *imagePath;
        imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];

        CGSize size = UIScreen.mainScreen.bounds.size;
        CGSize cropSize;
        cropSize.width = img.size.width;
        cropSize.height = img.size.width * size.height / size.width;
        CGRect cropRect = CGRectMake(0, 0, (cropSize.width * img.scale), (cropSize.height * img.scale));
        
        UIGraphicsImageRendererFormat *fmtt = [[UIGraphicsImageRendererFormat alloc] init];
        fmtt.scale = 1;
        fmtt.opaque = NO;
        fmtt.preferredRange = UIGraphicsImageRendererFormatRangeExtended;
        
        UIImage *aImage;
        @autoreleasepool {
            UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:cropRect.size format:fmtt];
            aImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                [img drawInRect:CGRectMake(0, 0, img.size.width*img.scale, img.size.height*img.scale)];
            }];
        }
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        iv.image = aImage;
        [self.view addSubview:iv];
    }

    - (void)testClearImgRendererWithSmallSize
    {
        NSString *imagePath;
        imagePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:imagePath];

        CGSize size = UIScreen.mainScreen.bounds.size;
        CGSize cropSize;
        cropSize.width = img.size.width;
        cropSize.height = img.size.width * size.height / size.width;
        CGRect cropRect = CGRectMake(0, 0, (cropSize.width * img.scale), (cropSize.height * img.scale));
        
        UIGraphicsImageRendererFormat *fmtt = [[UIGraphicsImageRendererFormat alloc] init];
        fmtt.scale = 0.3;
        fmtt.opaque = NO;
        fmtt.preferredRange = UIGraphicsImageRendererFormatRangeExtended;
        
        UIImage *aImage;
        @autoreleasepool {
            UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:cropRect.size format:fmtt];
            aImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                [img drawInRect:CGRectMake(0, 0, img.size.width*img.scale, img.size.height*img.scale)];
            }];
        }
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        iv.image = aImage;
        [self.view addSubview:iv];
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
