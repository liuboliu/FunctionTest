//
//  MyOperation.m
//  TEXT
//
//  Created by Apple on 2021/2/9.
//  Copyright © 2021 刘博. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

- (void)main
{
    NSLog(@"run operation: %@",self.name);

    [NSThread sleepForTimeInterval:3];

    NSLog(@"run operation: %@",self.name);
}

@end
