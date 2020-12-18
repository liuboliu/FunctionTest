//
//  VVAdultShoeStandSizeSegmentCell.h
//  VOVA
//
//  Created by MacBook on 2019/5/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVViewProtocol.h"

@protocol VVAdultShoeStandSizeSegmentCellDelegate <NSObject>

- (void)femaleBtnClick;
- (void)maleBtnClick;

@end

NS_ASSUME_NONNULL_BEGIN

@interface VVAdultShoeStandSizeSegmentCell : UITableViewCell <VVViewProtocol>

@property (nonatomic, weak) id <VVAdultShoeStandSizeSegmentCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
