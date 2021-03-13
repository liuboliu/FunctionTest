//
//  ListModel.h
//  TEXT
//
//  Created by Apple on 2021/3/13.
//  Copyright © 2021 刘博. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void (^block)(void);

@end

NS_ASSUME_NONNULL_END
