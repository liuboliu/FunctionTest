//
//  SizeChartModel.h
//  FloryDay
//
//  Created by Dwayne on 2018/3/14.
//  Copyright © 2018年 FloryDay. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface VVSizeChartModel : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *inch;
@property (nonatomic, copy) NSString *cm;
@property (nonatomic, copy) NSString *value;

@end
