//
//  FBRequest.h
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping/EasyMapping.h>
#import <AFNetworking/AFNetworking.h>
#import "EasyMapping.h"



extern NSString * const kFBRequestMethodGET;



@interface FBRequest : NSObject

@property (nonatomic, readonly) NSURLSessionDataTask *task;
@property (nonatomic) EKObjectMapping *responseMapping;
@property (nonatomic, copy) NSString *HTTPmethod;
@property (nonatomic, copy) NSString *URLString;
@property (nonatomic, copy) id parameters;

- (id)handleError:(NSError*)error statusCode:(NSInteger)statusCode;
- (id)handleSuccessResponce:(id)responce;
- (id)performMappingForResponce:(id)responce;

- (void)fetchWithProgress:(void (^)(NSProgress *))progress handler:(void(^)(id response, id error))handler;

@end
