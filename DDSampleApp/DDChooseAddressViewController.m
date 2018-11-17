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

@class CLPlacemark;

@interface DDChooseAddressViewController () <DDUserSelectedLocationListner>
@property (weak, nonatomic) IBOutlet UIView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *addressSelected;
@property (nonatomic) DDDataManager *dataManager;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic) id<DDLocationService> locationService;
@property (nonatomic) DDMapViewViewController *mapViewController;
@property (nonatomic) UITapGestureRecognizer *mapTapGesture;

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
    
    [self setLocationInAddressLabel:[self.locationService currentUserLocation]];

}

- (void)mapTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.mapViewController mapTapAction:tapGestureRecognizer processBlock:^(NSString *address) {
        [self.addressLabel setText:address];
    }];
}


//- (void)setAddressForLocation:(CLLocation *)location {
//    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Geocode failed with error: %@", error);
//            return; // Request failed, log error
//        }
//
//        // Check if any placemarks were found
//        if (placemarks && placemarks.count > 0)
//        {
//            CLPlacemark *placemark = placemarks[0];
//
//            // Dictionary containing address information
//            CNPostalAddress *postalAddress =
//            placemark.postalAddress;
//
//            NSString *completeAddress = [[NSString alloc] initWithFormat:@"%@ %@", postalAddress.street, postalAddress.city];
//            [self.addressLabel setText:completeAddress];
//        }
//    }];
//}

//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    MKCoordinateRegion mapRegion;
//    mapRegion.center = mapView.userLocation.coordinate;
//    mapRegion.span.latitudeDelta = 0.2;
//    mapRegion.span.longitudeDelta = 0.2;
//    
//    [mapView setRegion:mapRegion animated: YES];
//    
//    CLLocationCoordinate2D noLocation = self.locationManager.location.coordinate;
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 800, 800);
//    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
//    [self.mapView setRegion:adjustedRegion animated:YES];
//    
//    [self setAddressForLocation:userLocation.location];
//}

#pragma mark - DDUserSelectedLocationListner

- (void)userDidSelectLocation:(CLLocation *)location {
    [self setLocationInAddressLabel:location];
}

- (void)setLocationInAddressLabel:(CLLocation *)newLocation {
    [self.locationService currentUserFriendlyAddress:newLocation processBlock:^(NSString *address) {
        [self.addressLabel setText:address];
    }];
}

@end
