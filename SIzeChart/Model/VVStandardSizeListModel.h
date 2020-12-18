//
//  VVAdultSizeListModel.h
//  VOVA
//
//  Created by MacBook on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@class VVStandardSizeListModel;
@class VVStandardSizeValueModel;
@protocol VVStandardSizeValueModel;

/// 尺码表新增性别分类
@interface VVStandardSizeGenderModel : JSONModel

/// 性别：Female、Male
@property (nonatomic, copy) NSString *attr_name;
/// 属于某个性别的尺码
@property (nonatomic, strong) NSArray<VVStandardSizeListModel *> *attr_value;

@end

@interface VVStandardSizeListModel : JSONModel

@property (nonatomic, copy) NSString *attr_name;
@property (nonatomic, strong) VVStandardSizeValueModel *attr_value;

@end

@interface VVStandardSizeValueModel : JSONModel

@property (nonatomic, copy) NSString *eu;
@property (nonatomic, copy) NSString *us;
@property (nonatomic, copy) NSString *uk;

@end

NS_ASSUME_NONNULL_END
