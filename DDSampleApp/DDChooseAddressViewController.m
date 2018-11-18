//
//  DDChooseAddressViewController.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/16/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDChooseAddressViewController.h"
#import <MapKit/MapKit.h>
#import "DDDataManager.h"
#import <Contacts/CNPostalAddress.h>
#import "DDLocationService.h"
#import "DDLocationServiceImpl.h"
#import "DDMapViewViewController.h"
#import "DDGlobalContstants.h"
#import "DDTabBarViewController.h"

@class CLPlacemark;

@interface DDChooseAddressViewController () <DDUserSelectedLocationListner>
@property (weak, nonatomic) IBOutlet UIView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *addressSelected;
@property (nonatomic) DDDataManager *dataManager;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic) id<DDLocationService> locationService;
@property (nonatomic) DDMapViewViewController *mapViewController;
@property (nonatomic) UITapGestureRecognizer *mapTapGesture;
@property (nonatomic) CLLocation *currentSelectedLocation;
@end

@implementation DDChooseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapViewController = [DDMapViewViewController new];
    self.mapViewController.delegate = self;
    self.mapViewController.view.frame = self.mapView.bounds;
    [self.mapView addSubview:self.mapViewController.view];

    self.locationService = [DDLocationServiceImpl new];
    self.dataManager = [DDDataManager new];
    
    self.mapTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapAction:)];
    [self.mapView addGestureRecognizer:self.mapTapGesture];
    
    [self.locationService enableLocation];
    
    if (![self.locationService isLocationServiceEnable]) {
        [self.locationService forceRequestLocation];    
    }
    
    [self setLocationInAddressLabel:[self.locationService currentUserLocation]];

}

- (void)mapTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.mapViewController mapTapAction:tapGestureRecognizer];
}

- (IBAction)confirmAddressButtonDidTap:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORY_BOARD_MAIN_NAME bundle: nil];
    DDTabBarViewController *tabBarViewController = (DDTabBarViewController *)[storyboard instantiateViewControllerWithIdentifier:STORY_BOARD_ID_TAB_BAR_VIEW_CONTROLLER];
    tabBarViewController.location = self.currentSelectedLocation;
    [self.navigationController pushViewController:tabBarViewController animated:YES];
}

#pragma mark - DDUserSelectedLocationListner

- (void)userDidSelectLocation:(CLLocation *)location {
    [self setLocationInAddressLabel:location];
}

- (void)setLocationInAddressLabel:(CLLocation *)newLocation {
    self.currentSelectedLocation = newLocation;

    [self.locationService currentUserFriendlyAddress:newLocation processBlock:^(NSString *address) {
        [self.addressLabel setText:address];
    }];
}

@end
