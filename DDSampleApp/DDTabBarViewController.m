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

#pragma mark - ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setExploreVCLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setExploreVCLocation];

    // Set back button View
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-address"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped:)];
    
    newBackButton.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = newBackButton;

    // Setting Title
    UILabel *titleLable = [[UILabel alloc] initWithFrame:self.navigationItem.titleView.bounds];
    [titleLable setTextColor:[UIColor redColor]];
    [titleLable setText:@"DoorDash"];
    self.navigationItem.titleView = titleLable;
}

#pragma mark - PrivateMethods

// Passing down the location data to explore view controller
- (void)setExploreVCLocation {
    NSArray<UIViewController *> *controllers = self.viewControllers;
    
    for (UIViewController *controller in controllers) {
        if ([controller isKindOfClass:[DDExploreViewController class]]) {
            DDExploreViewController *exploreController = (DDExploreViewController *)controller;
            exploreController.location = self.location;
        }
    }
}

- (void)backButtonTapped:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
