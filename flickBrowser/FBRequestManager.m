//
//  FBRequestManager.m
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import "FBRequestManager.h"
#import "AFNetworkActivityLogger.h"
#import "FBRequest.h"



@interface FBJSONRequestSerializer : AFJSONRequestSerializer

@end



@implementation FBJSONRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
{
    NSMutableURLRequest *result = [super requestWithMethod:method URLString:URLString parameters:parameters error:error];
    
    NSDictionary *headers = [FBRequestManager sharedInstance].headers;
    for (NSString *key in headers.allKeys) {
        [result setValue:headers[key] forHTTPHeaderField:key];
    }
    
    return result;
}

@end


@interface FBRequest (Private)

- (void)setTask:(NSURLSessionDataTask *)task;

@end



@interface FBRequestManager ()

@property (nonatomic, readonly) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, strong) FBJSONRequestSerializer *requestSerializer;

@end



@implementation FBRequestManager

static FBRequestManager *g_instance;

+ (FBRequestManager *)sharedInstance
{
    return g_instance;
}

+ (FBRequestManager *)initializeWithBaseURL:(NSURL *)url
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[self alloc] initWithBaseURL:url];
        [[AFNetworkActivityLogger sharedLogger] startLogging];
#if defined DEBUG
        [[AFNetworkActivityLogger sharedLogger] startLogging];
        for (id<AFNetworkActivityLoggerProtocol> logger in [AFNetworkActivityLogger sharedLogger].loggers) {
            [logger setLevel:AFLoggerLevelDebug];
        }
#else
        for (id<AFNetworkActivityLoggerProtocol> logger in [AFNetworkActivityLogger sharedLogger].loggers) {
            [logger setLevel:AFLoggerLevelOff];
        }
#endif
    });
    return g_instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        _baseURL = url;
        _headers = [NSMutableDictionary new];
        [self initiliazeNetwork];
    }
    return self;
}

- (void)initiliazeNetwork
{
    self.requestSerializer = [[FBJSONRequestSerializer alloc] init];
    self.requestSerializer.writingOptions = 0;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _sessionConfiguration = configuration;
    _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL sessionConfiguration:configuration];
    _sessionManager.requestSerializer = self.requestSerializer;
}

- (void)fetchRequest:(FBRequest *)request withProgress:(void (^)(NSProgress *))progress handler:(void(^)(id response, id error))handler
{
    NSURLSessionDataTask *result = nil;
    
    void (^errorHandler)(NSURLSessionDataTask *task, NSError *error) = ^
    (NSURLSessionDataTask *task, NSError *error)
    {
        NSInteger statusCode = 0;
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]])
        {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            statusCode = response.statusCode;
        }
        
        id resultError = [request handleError:error statusCode:statusCode];
        PERFORM_BLOCK_IF_NOT_NIL(handler, nil, resultError);
    };
    
    NSString *method = request.HTTPmethod;
    if ([method isEqualToString:kFBRequestMethodGET])
    {
        result = [self.sessionManager GET:request.URLString
                               parameters:request.parameters
                                 progress:progress
                                  success:^(NSURLSessionDataTask *task, id responseDict)
                  {
                      id responseObject = [request handleSuccessResponce:responseDict];
                      PERFORM_BLOCK_IF_NOT_NIL(handler, responseObject, nil);
                  }
                                  failure:errorHandler];
    }
   
    [request setTask:result];
}

@end
