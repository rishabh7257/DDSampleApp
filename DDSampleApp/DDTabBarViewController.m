//
//  DDTabBarViewController.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDTabBarViewController.h"
#import "DDExploreViewController.h"

@implementation DDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<UIViewController *> *controllers = self.viewControllers;
    
    for (UIViewController *controller in controllers) {
        if ([controller isKindOfClass:[DDExploreViewController class]]) {
            DDExploreViewController *exploreController = (DDExploreViewController *)controller;
            exploreController.location = self.location;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray<UIViewController *> *controllers = self.viewControllers;
    
    for (UIViewController *controller in controllers) {
        if ([controller isKindOfClass:[DDExploreViewController class]]) {
            DDExploreViewController *exploreController = (DDExploreViewController *)controller;
            exploreController.location = self.location;
        }
    }
}

@end
