//
//  VVAdultSizeListModel.m
//  VOVA
//
//  Created by MacBook on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "VVStandardSizeListModel.h"

@implementation VVStandardSizeGenderModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (Class)classForCollectionProperty:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"attr_value"]) {
        return VVStandardSizeListModel.class;
    } else {
        return nil;
    }
}

@end

@implementation VVStandardSizeListModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation VVStandardSizeValueModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
