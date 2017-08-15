//
//  ViewController.m
//  flickBrowser
//
//  Created by Katekov Anton on 8/14/17.
//  Copyright © 2017 katekovanton. All rights reserved.
//

#import "ViewController.h"
#import "FBAssembly.h"



@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[FBAssembly sharedInstance] setupWithRootViewController:self];
}

@end
