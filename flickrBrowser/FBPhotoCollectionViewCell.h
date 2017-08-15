//
//  FBPhotoCollectionViewCell.h
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import <UIKit/UIKit.h>



@class FBPhoto;



@interface FBPhotoCollectionViewCell : UICollectionViewCell {
    IBOutlet UIImageView *_image;
}

@property (nonatomic) FBPhoto *photo;

@end
