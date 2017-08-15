//
//  FBRequest.m
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import "FBRequest.h"
#import "FBRequestManager.h"



NSString * const kFBRequestMethodGET       = @"GET";




@implementation FBRequest

- (instancetype)init
{
    if (self = [super init]) {
        self.HTTPmethod = kFBRequestMethodGET;
    }
    return self;
}

- (void)setTask:(NSURLSessionDataTask *)task
{
    if (_task != nil && _task.state == NSURLSessionTaskStateRunning) {
        [_task cancel];
    }
    _task = task;
}

- (id)handleError:(NSError*)error statusCode:(NSInteger)statusCode
{
    //do something
    return error;
}

- (id)handleSuccessResponce:(id)responce
{
    return [self performMappingForResponce:responce];
}

- (id)performMappingForResponce:(id)responce
{
    if (responce != nil)
    {
        if (self.responseMapping != nil)
        {
            id result = [EKMapper objectFromExternalRepresentation:responce withMapping:self.responseMapping];
            return result;
        }
        return responce;
    }
    
    return nil;
}

- (void)fetchWithProgress:(void (^)(NSProgress *))progress handler:(void(^)(id response, id error))handler
{
    [[FBRequestManager sharedInstance] fetchRequest:self withProgress:progress handler:handler];
}

- (void)dealloc
{
    [_task cancel];
}

@end
