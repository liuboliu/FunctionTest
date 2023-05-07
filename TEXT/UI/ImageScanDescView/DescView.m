//
//  DescView.m
//  ThePaperHD
//
//  Created by YoungLee on 15/6/18.
//  Copyright (c) 2015年 scar1900. All rights reserved.
//
#define isIOS8  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8
#define rect_screen [[UIScreen mainScreen]bounds]
#define IS_IPHONE_X ({\
BOOL iphonex = NO;\
if (@available(iOS 11.0, *)) {\
CGFloat height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;\
if (height > 0) {\
iphonex = YES;\
}\
}\
(iphonex);})\

#import "DescView.h"
#import <CoreImage/CoreImage.h>

@interface DescView (){
    CGFloat jianjuLeft;//左间距
    CGFloat jianjuRight;//右间距
    CGFloat descViewY;
}

//背景view
@property (nonatomic , strong) UIView *backGroundView;


@end


@implementation DescView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    UIView *v = [super hitTest:point withEvent:event];
    if ([v isKindOfClass:[DescView class]]) {
        return nil;
    }
    return v;
}

- (id)initWithDescString:(NSString *)descString tagString:(NSString *)tagString andAuthor:(NSString *)author
{
    self = [super initWithFrame:CGRectZero];
    if (nil != self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor cyanColor];
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        self.showsVerticalScrollIndicator = NO;
        [self addSubview:self.backGroundView];
        
        descViewY = 37;
        
        /**
         横屏背景模糊效果
         */
        
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blur];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
        UIView *blackView = [[UIView alloc] init];
        blackView.backgroundColor = [UIColor yellowColor];
        blackView.alpha = 0.75;
        [effe.contentView addSubview:blackView];
        UIToolbar *toolBar = [[UIToolbar alloc] init];
        toolBar.barStyle = UIBarStyleBlack;
        if (isIOS8) {
            [self.backGroundView addSubview:effe];
        } else {
            [self.backGroundView addSubview:toolBar];
        }
    

        
        self.bounces = NO;
        if (!author || orientation == UIInterfaceOrientationLandscapeRight
            || orientation ==UIInterfaceOrientationLandscapeLeft) {
            //减去刘海高度
            jianjuLeft = IS_IPHONE_X?45:21;
            jianjuRight = IS_IPHONE_X?45:21;
            descString = [NSString stringWithFormat:@"%@ %@",tagString,descString];
            
//            self.backGroundView.backgroundColor = [UIColor clearColor];
//            if (isIOS8) {
//                effe.hidden = NO;
//            } else {
//                toolBar.hidden = NO;
//            }
            
        } else {
            jianjuLeft = 21;
            jianjuRight = 21;
//            author = [NSString stringWithFormat:@"责任编辑：%@",author];
            descString = [NSString stringWithFormat:@"%@ %@\n%@",tagString,descString,author];
//            self.backGroundView.backgroundColor = [UIColor blackColor];
////            self.backGroundView.alpha = 0.8;
//            if (isIOS8) {
//                effe.hidden = YES;
//            } else {
//                toolBar.hidden = YES;
//            }
        }
        
        UILabel  *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(jianjuLeft, 10, rect_screen.size.width-jianjuLeft-jianjuRight, 14)];
        descLabel.font = [UIFont systemFontOfSize:15];
        descLabel.numberOfLines = 0;
        descLabel.textColor = [UIColor redColor];
        CGFloat oneLine = 5 + [UIFont systemFontOfSize:15].lineHeight;
        NSAttributedString *attr = [self getLineSpaceAttributedString:descString linespace:5 font:[UIFont systemFontOfSize:15]];
        
        NSArray *array = [tagString componentsSeparatedByString:@"/"];
        NSString *first = array[0];
        NSString *change = array[1];
        NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
        [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [tagString length])];
        [strAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange([first length], [change length]+1)];
        
        if (!author || orientation == UIInterfaceOrientationLandscapeRight
            || orientation ==UIInterfaceOrientationLandscapeLeft) {
        } else {
            NSRange authorRange = [descString rangeOfString:author];
            NSMutableParagraphStyle *descStyle = [[NSMutableParagraphStyle alloc]init];
            descStyle.alignment = NSTextAlignmentRight;
            [strAtt addAttribute:NSParagraphStyleAttributeName value:descStyle range:authorRange];
        }
        
        descLabel.attributedText = strAtt;
        CGSize size;
        
        if (orientation == UIInterfaceOrientationLandscapeRight
            || orientation ==UIInterfaceOrientationLandscapeLeft) {
            
            size = [descLabel sizeThatFits:CGSizeMake(rect_screen.size.width-jianjuLeft-jianjuRight, CGFLOAT_MAX)];
            
            self.frame = CGRectMake(0, rect_screen.size.height-size.height-20, rect_screen.size.width, size.height+20);
            
            if (size.height > oneLine*3) {//三行
                self.backGroundView.frame = CGRectMake(0, size.height - oneLine*3-3+10, rect_screen.size.width, size.height+20);
                
                effe.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                blackView.frame = effe.bounds;
                toolBar.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                
                if (IS_IPHONE_X) {
                    self.contentSize = CGSizeMake(0, size.height+self.backGroundView.frame.origin.y);
                } else {
                    self.contentSize = CGSizeMake(0, size.height+self.backGroundView.frame.origin.y+20);
                }
                self.scrollEnabled = YES;
                
            } else {
                self.backGroundView.frame = CGRectMake(0, 0 , rect_screen.size.width, size.height+6+20);
                
                effe.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                blackView.frame = effe.bounds;
                toolBar.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                
                self.scrollEnabled = NO;
            }
            
            
        }else {
            
            size = [descLabel sizeThatFits:CGSizeMake(rect_screen.size.width-jianjuLeft-jianjuRight, CGFLOAT_MAX)];
            if (size.height > oneLine*5) {//五行
                
                descViewY = 37;
                
                self.backGroundView.frame = CGRectMake(0, size.height - oneLine*5-3, rect_screen.size.width, size.height+6+10);
                
                effe.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                blackView.frame = effe.bounds;
                toolBar.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                
                self.contentSize = CGSizeMake(0, size.height+10+self.backGroundView.frame.origin.y+[self getSafeAreaBottomHeight]);
                self.scrollEnabled = YES;
            } else {
                
                descViewY = 45;
                
                self.backGroundView.frame = CGRectMake(0, 0 , rect_screen.size.width, size.height+6+10);
                
                effe.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                blackView.frame = effe.bounds;
                toolBar.frame = CGRectMake(0, 0, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
                
                self.scrollEnabled = NO;
            }
            
            self.frame = CGRectMake(0, rect_screen.size.height-size.height-descViewY-10-[self getSafeAreaBottomHeight], rect_screen.size.width, size.height+10+[self getSafeAreaBottomHeight]);
            
        }
        
        descLabel.frame = CGRectMake(jianjuLeft, 10, rect_screen.size.width-jianjuLeft-jianjuRight, size.height);
        
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite; //bug:4995(图集：图说超过5行没有滚动条)
        [self.backGroundView addSubview:descLabel];
        
    }
    return self;
}


-(UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] init];
//        _backGroundView.backgroundColor = [UIColor blackColor];
//        _backGroundView.alpha = 0.8;
    }
    return _backGroundView;
}


- (NSAttributedString *)getLineSpaceAttributedString:(NSString*) string linespace:(CGFloat) lineSpace font:(UIFont*) font{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;// 字体的行间距
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                paragraphStyle,NSParagraphStyleAttributeName,
                                nil];
    NSString *oriString = @"";
    if (string) {
        oriString = string;
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithString:oriString attributes:attributes];
    /**
     * bug:5838(【倒退】离线缓存：205环境的离线缓存中思想频道的“一带一路不存在缺席省份...”闪退)
     */
    return attributeStr;
}

- (CGFloat)getSafeAreaBottomHeight{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}


@end

