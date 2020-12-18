//
//  sizeListModel.h
//  FloryDay
//
//  Created by Dwayne on 2018/3/14.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol VVSizeChartModel

@end

@class VVAdultSizeShowModel;

@interface VVSizeListModel : JSONModel

@property (nonatomic,strong) NSArray<VVSizeChartModel>  *attr_value;
@property (nonatomic,copy) NSString *attr_name;

@end

@interface VVAdultSizeShowModel : JSONModel

@property (nonatomic, copy) NSString *feet_length;
@property (nonatomic, copy) NSString *insole_length;
@property (nonatomic, copy) NSString *shoes_length;
@property (nonatomic, copy) NSString *length;

@end
