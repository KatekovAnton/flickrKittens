//
//  FBRequestManager.h
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>



@class FBRequest;



@interface FBRequestManager : NSObject

@property (nonatomic, copy) NSMutableDictionary *headers;

+ (FBRequestManager *)sharedInstance;
+ (FBRequestManager *)initializeWithBaseURL:(NSURL *)url;

- (void)fetchRequest:(FBRequest *)request withProgress:(void (^)(NSProgress *))progress handler:(void(^)(id response, id error))handler;

@end
