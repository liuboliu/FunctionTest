//
//  LMJHorizontalScrollText.m
//  LMJHorizontalScrollTextExample
//
//  Created by LiMingjie on 2019/8/22.
//  Copyright © 2019 LMJ. All rights reserved.
//

#import "LMJHorizontalScrollText.h"

@interface LMJHorizontalScrollText()

@property (nonatomic, strong) UILabel * contentLabel1;
@property (nonatomic, strong) UILabel * contentLabel2;

@property (nonatomic, assign) CGFloat textWidth;
@property (nonatomic, assign) int wanderingOffset;

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation LMJHorizontalScrollText
{
    CGFloat _selfWidth;
    CGFloat _selfHeight;
}

#pragma mark - Init
- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 100, 20); // 设置一个初始的frame
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setInitialSettings];
        [self addSubview:self.contentLabel1];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setInitialSettings];
}

- (void)layoutSubviews{
    _selfWidth = self.frame.size.width;
    _selfHeight = self.frame.size.height;
}

- (void)setInitialSettings {
    self.clipsToBounds = YES;
    
    _contentLabel1 = nil;
    _contentLabel2 = nil;
    
    _text      = @"";
    _textFont  = [UIFont systemFontOfSize:12];
    _textColor = [UIColor blackColor];
    
    _speed = 0.03;
    _textWidth = 0;
    _wanderingOffset = -1;
    
    _timer = nil;
    
    _selfWidth = self.frame.size.width;
    _selfHeight = self.frame.size.height;
}


#pragma mark - Set
- (void)setText:(NSString *)text{
    if ([_text isEqualToString: text]) return;
    _text = text;
    [self updateTextWidth];
    [self updateLabelsFrame];
    if (_contentLabel1 != nil) {
        _contentLabel1.text = _text;
    }
    if (_contentLabel2 != nil) {
        _contentLabel2.text = _text;
    }
}

- (void)setTextFont:(UIFont *)textFont{
    if (_textFont == textFont) return;
    _textFont = textFont;
    [self updateTextWidth];
    [self updateLabelsFrame];
    if (_contentLabel1 != nil) {
        self.contentLabel1.font = _textFont;
    }
    if (_contentLabel2 != nil) {
        _contentLabel2.font = _textFont;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    if (_contentLabel1 != nil) {
        _contentLabel1.textColor = _textColor;
    }
    if (_contentLabel2 != nil) {
        _contentLabel2.textColor = _textColor;
    }
}

- (void)setSpeed:(CGFloat)speed{
    _speed = speed;
}

#pragma mark - Create Labels
-(void)creatLabel1WithFrame:(CGRect)frame{
    _contentLabel1 = [[UILabel alloc] initWithFrame:frame];
    _contentLabel1.text            = self.text;
    _contentLabel1.font            = self.textFont;
    _contentLabel1.textColor       = self.textColor;
    _contentLabel1.tag             = 1001;
    _contentLabel1.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentLabel1];
    
    if (_contentLabel2) {
        [_contentLabel2 removeFromSuperview];
        _contentLabel2 = nil;
    }
}
-(void)creatLabel1WithFrame1:(CGRect)frame1 andLabel2WithFrame2:(CGRect)frame2{
    [self creatLabel1WithFrame:frame1];
    
    _contentLabel2 = [[UILabel alloc] initWithFrame:frame2];
    _contentLabel2.text            = self.text;
    _contentLabel2.font            = self.textFont;
    _contentLabel2.textColor       = self.textColor;
    _contentLabel2.tag             = 1002;
    _contentLabel2.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentLabel2];
}


#pragma mark - Util
- (void)updateTextWidth {
    _textWidth = [self.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.textFont, NSFontAttributeName, nil]].width;
}

- (void)updateLabelsFrame {
    
    CGFloat label1_x = self.contentLabel1.frame.origin.x;
    CGFloat label2_x = self.contentLabel2.frame.origin.x;

    if (self.contentLabel1 && self.contentLabel2) {
        if (label1_x < label2_x) {
            _contentLabel1.frame = CGRectMake(label1_x, 0, _textWidth, _selfHeight);
            _contentLabel2.frame = CGRectMake(label1_x + _textWidth, 0, _textWidth, _selfHeight);
        } else {
            _contentLabel2.frame = CGRectMake(label2_x, 0, _textWidth, _selfHeight);
            _contentLabel1.frame = CGRectMake(label2_x + _textWidth, 0, _textWidth, _selfHeight);
            
        }
    } else {
        if (_contentLabel1) {
            _contentLabel1.frame = CGRectMake(label1_x, 0, _textWidth, _selfHeight);
        }
        if (_contentLabel2) {
            _contentLabel2.frame = CGRectMake(label2_x, 0, _textWidth, _selfHeight);
        }
    }
}

- (void)resetLabelsPosition {
    self.contentLabel1.frame = CGRectMake(0, 10, _textWidth, _selfHeight);
    
}

#pragma mark - Move Action
// LMJTextScrollIntermittent
-(void)moveIntermittent {
    self.contentLabel1.frame = CGRectMake(self.contentLabel1.frame.origin.x -1, 0, _textWidth, _selfHeight);
    if (_contentLabel1.frame.origin.x < - (_textWidth + 10 - CGRectGetWidth(self.bounds))) {
        [_timer invalidate];
        _timer = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.contentLabel1.frame = CGRectMake(10, 0, self.textWidth, self->_selfHeight);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self move];
            });
            
        });
    }
}
#pragma mark - API Methods
- (void)move {
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.speed target:self selector:@selector(moveIntermittent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self->_timer forMode:NSRunLoopCommonModes];
}

- (void)stop {
    [_timer invalidate];
    _timer = nil;
    [self resetLabelsPosition];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (UILabel *)contentLabel1
{
    if (!_contentLabel1) {
        _contentLabel1 = [[UILabel alloc] init];
        _contentLabel1.textColor = [UIColor cyanColor];
        _contentLabel1.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel1;
}

@end
