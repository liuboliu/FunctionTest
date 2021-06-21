//
//  LMJHorizontalScrollText.h
//  LMJHorizontalScrollTextExample
//
//  Created by LiMingjie on 2019/8/22.
//  Copyright © 2019 LMJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface LMJHorizontalScrollText : UIView

@property (nonatomic,copy)   NSString  * text;
@property (nonatomic,copy)   UIFont  * textFont;
@property (nonatomic,copy)   UIColor * textColor;

@property (nonatomic,assign) CGFloat speed;


- (void)move;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
