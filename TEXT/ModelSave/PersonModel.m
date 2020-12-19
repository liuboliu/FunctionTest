//
//  PersonModel.m
//  TEXT
//
//  Created by 刘博 on 2020/12/19.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (id)initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.gender = [coder decodeObjectForKey:@"gender"];
    }
    return self;
}

- (void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_gender forKey:@"gender"];
}

@end
