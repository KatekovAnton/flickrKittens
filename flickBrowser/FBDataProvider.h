//
//  FBDataProvider.h
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import <Foundation/Foundation.h>



@class FBPhotosController;



@interface FBDataProvider : NSObject

@property (nonatomic, readonly) FBPhotosController *photosController;

+ (FBDataProvider *)sharedInstance;

@end
