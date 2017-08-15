//
//  FBPhotosViewController.m
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import "FBPhotosViewController.h"
#import "FBPhotoCollectionViewCell.h"



@interface FBPhotosViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSMutableArray *_photos;
}

@end



@implementation FBPhotosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _photos = [NSMutableArray new];
    [_collection registerNib:[UINib nibWithNibName:@"FBPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FBPhotoCollectionViewCell"];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collection.collectionViewLayout;
    CGSize size = CGSizeZero;
    
    CGFloat elementCount = 3;
    CGFloat elementSpace = 10;
    size.width = ([UIScreen mainScreen].bounds.size.width - (elementCount - 1) * elementSpace) / elementCount;
    size.height = size.width;
    layout.itemSize = size;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadMorePhotosIfNeeded];
}

- (void)handleOnPhotosLoaded:(NSArray *)photos error:(NSError *)error
{
    if (error != nil) {
        // present error
        return;
    }
    NSUInteger startIndex = _photos.count;
    NSUInteger count = photos.count;
    [_photos addObjectsFromArray:photos];
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSUInteger i = 0; i < count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:startIndex + i inSection:0]];
    }
    [_collection insertItemsAtIndexPaths:indexPaths];
}

- (void)loadMorePhotosIfNeeded
{
    if (_collection.contentOffset.y + _collection.frame.size.height > _collection.contentSize.height - 100) {
        PERFORM_BLOCK_IF_NOT_NIL(self.handlerOnScrollToBottom);
    }
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self loadMorePhotosIfNeeded];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FBPhotoCollectionViewCell *cell = (FBPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FBPhotoCollectionViewCell" forIndexPath:indexPath];
    cell.photo = _photos[indexPath.row];
    return cell;
}

@end
