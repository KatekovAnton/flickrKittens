//
//  FBPhotosViewController.h
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FBPhotosViewController : UIViewController {
    IBOutlet UICollectionView *_collection;
}

@property (nonatomic, copy) FBEmptyBlock handlerOnScrollToBottom;

- (void)handleOnPhotosLoaded:(NSArray *)photos error:(NSError *)error;

@end
