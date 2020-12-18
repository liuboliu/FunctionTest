//
//  VVSizeChartViewModel.m
//  VOVA
//
//  Created by MacBook on 2019/6/11.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVSizeChartViewModel.h"
#import "VVSizeListModel.h"
#import "VVStandardSizeListModel.h"
#import "VVSizeChartModel.h"

@interface VVSizeChartViewModel ()

@property (nonatomic, assign) BOOL isLoadSizeChart;

@end

@implementation VVSizeChartViewModel
- (void)getSizeChartDataWithVirtualGoodsId:(NSString *)virtual_goods_id result:(void (^)(BOOL sucess))result
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:virtual_goods_id forKey:@"virtual_goods_id"];
    @weakify(self);
    [VVApi surfaceSizeChartWithParam:params result:^(NSString *errorMsg, id data) {
        @strongify(self);
        if (!errorMsg) {
            NSArray *array = [VVSizeListModel arrayOfModelsFromDictionaries:data[@"size"] error:nil];
            self.sizeChartArray = array;
            
            NSArray *standard_size = vv_safeArray(data[@"standard_size"]);
            NSDictionary *genderDictionary = vv_safeDict(standard_size.firstObject);
            NSArray *sizeArray = [genderDictionary vv_arrayForKey:@"attr_value"];
            NSDictionary *sizeDictionary = vv_safeDict(sizeArray.firstObject);
            NSString *name = [sizeDictionary vv_stringForKey:@"attr_name"];
            if (vv_safeStr(name)) {
                //默认顺序， eu ,us ,uk
                NSMutableArray *mkeyArray = [@[@"eu",@"us",@"uk"] mutableCopy];
                [mkeyArray removeObject:name.lowercaseString];
                [mkeyArray insertObject:name.lowercaseString atIndex:0];
                
                self.standardSizeKeyArray = mkeyArray.copy;
            }
            [self paserDateGetCmSizeArrayInchSizeArrayWithData:data array:array];
            self.sizeTips = [data objectForKey:@"size_tips"];
            self.isLoadSizeChart = YES;
            if (result) {
                result(YES);
            }
        } else {
            if (result) {
                result(NO);
            }
        }
    }];
}

//获取标准码数组，CMsize数组和INCHsize数组
- (void)paserDateGetCmSizeArrayInchSizeArrayWithData:(NSDictionary *)data array:(NSArray *)array
{
    NSArray *standardArray = [VVStandardSizeGenderModel arrayOfModelsFromDictionaries:[data objectForKey:@"standard_size"] error:nil];
    self.standardSizeList = standardArray;
    
    if (standardArray.count > 0 && self.sizeChartArray.count > 0) {
        NSInteger count = self.sizeChartArray.firstObject.attr_value.count;
        for (int i = 1; i < array.count; i ++) {
            VVSizeListModel *model = array[i];
            if (count > model.attr_value.count) {
                count = model.attr_value.count;
            }
        }
        
        //将size数据组拼成两个二维数组，用作展示成人鞋的size数据
        NSMutableArray *cmsizeArray = [NSMutableArray array];
        NSMutableArray *insizeArray = [NSMutableArray array];
        NSMutableArray *firstItem = [NSMutableArray array];
        if (![self.standardSizeKeyArray containsObject:[self.sizeChartArray.firstObject.attr_name lowercaseString]] ) {
            self.sizeChartArray = nil;
            return;
        }
        for (int i = 0; i < self.sizeChartArray.count; i ++) {
            VVSizeListModel *model = self.sizeChartArray[i];
            [firstItem addObject:model.attr_name];
        }
        [cmsizeArray addObject:firstItem];
        [insizeArray addObject:firstItem];
        
        @autoreleasepool {
            for (int i = 0; i < count; i ++) {
                NSMutableArray *cmsizeItemArray = [NSMutableArray array];
                NSMutableArray *insizeItemArray = [NSMutableArray array];
                for (int j = 0; j < self.sizeChartArray.count; j ++) {
                    VVSizeChartModel *sizeItem = self.sizeChartArray[j].attr_value[i];
                    if (sizeItem.value) {
                        [cmsizeItemArray addObject:sizeItem.value];
                        [insizeItemArray addObject:sizeItem.value];
                    } else {
                        [cmsizeItemArray addObject:sizeItem.cm];
                        [insizeItemArray addObject:sizeItem.inch];
                    }
                }
                [cmsizeArray addObject:cmsizeItemArray];
                [insizeArray addObject:insizeItemArray];
            }
            self.cmSizeArray = cmsizeArray.copy;
            self.inchSizeArray = insizeArray.copy;
        }
    }
}

- (void)resetState
{
    self.isLoadSizeChart = NO;
}

@end
