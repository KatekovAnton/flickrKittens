//
//  FBAssembly.h
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FBAssembly : NSObject

+ (FBAssembly *)sharedInstance;
- (void)setupWithRootViewController:(UIViewController *)rootViewController;

@end
