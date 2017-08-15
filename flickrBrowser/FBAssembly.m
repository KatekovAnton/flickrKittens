//
//  FBAssembly.m
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import "FBAssembly.h"
#import "FBDataProvider.h"
#import "FBPhotosController.h"
#import "FBPhotosViewController.h"



@interface FBAssembly ()

@property (nonatomic) UIViewController *rootViewController;
@property (nonatomic) UINavigationController *rootNavigationController;

@end



@implementation FBAssembly

+ (FBAssembly *)sharedInstance
{
    static FBAssembly *sharedFBAssembly = nil;
    @synchronized (self) {
        if (sharedFBAssembly == nil) {
            sharedFBAssembly = [FBAssembly new];
        }
    }
    return sharedFBAssembly;
}

- (void)setupWithRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    [self setupApplication];
}

- (void)setupApplication
{
    FBPhotosViewController *photosScreen = [FBPhotosViewController new];
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:photosScreen];
    [self.rootViewController presentViewController:self.rootNavigationController animated:NO completion:nil];
    
    WEAK(photosScreen);
    photosScreen.handlerOnScrollToBottom = ^
    {
        [[FBDataProvider sharedInstance].photosController loadTailWithHandler:^(NSArray<__kindof FBPhoto *> *photos, NSError *error)
         {
             [photosScreen_weak_ handleOnPhotosLoaded:photos error:error];
         }];
    };
    
    // say if we have tap event for photo:
//    photosScreen.handlerOnPhotoTap = ^(FBPhoto *photo)
//    {
//        FBPhotoViewController *photoScreen = [FBPhotoViewController new];
//        photoScreen.photo = photo;
//        [photosScreen_weak_.navigationController pushViewController:photoScreen animated:YES];
//    };
}

@end
