//
//  FBObject.m
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import "FBObject.h"



@implementation FBObject

+ (EKObjectMapping *)objectMapping
{
    EKObjectMapping *mapping = [[EKObjectMapping alloc] initWithObjectClass:self];
    return mapping;
}

@end
