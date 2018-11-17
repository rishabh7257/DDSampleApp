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

@class CLPlacemark;

@interface DDChooseAddressViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *addressSelected;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) UITapGestureRecognizer *mapTapGesture;
@property (nonatomic) MKPointAnnotation *annotation;
@property (nonatomic) DDDataManager *dataManager;
@property (nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic) id<DDLocationService> locationService;

@end

@implementation DDChooseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationService = [DDLocationServiceImpl new];
    self.dataManager = [DDDataManager new];
    self.annotation = [[MKPointAnnotation alloc] init];
    self.geocoder = [CLGeocoder new];
    self.mapView.delegate = self;
    self.mapView.userInteractionEnabled = YES;
    self.mapTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTap:)];
    [self.mapView addGestureRecognizer:self.mapTapGesture];
    self.mapTapGesture.delegate = self;
    [self.mapView addAnnotation:self.annotation];
    
    [self.locationService enableLocation];
    
    [self.locationService currentUserFriendlyAddress:nil processBlock:^(NSString *address) {
        [self.addressLabel setText:address];
    }];

}

- (void)mapTap:(UITapGestureRecognizer *)recog {
    CGPoint point = [recog locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    [self.annotation setCoordinate:coordinate];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return; // Request failed, log error
        }
        
        // Check if any placemarks were found
        if (placemarks && placemarks.count > 0)
        {
            CLPlacemark *placemark = placemarks[0];
            
            // Dictionary containing address information
            CNPostalAddress *postalAddress =
            placemark.postalAddress;
            
            NSString *completeAddress = [[NSString alloc] initWithFormat:@"%@ %@", postalAddress.street, postalAddress.city];
        }
    }];
    [self.dataManager fetchRestaurantsData:coordinate];
    
}
- (void)viewDidAppear:(BOOL)animated {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    
    
}
- (void)disabledMyFeature {
    
}

- (void)enabledFeature {
    
}

- (void)setAddressForLocation:(CLLocation *)location {
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return; // Request failed, log error
        }
        
        // Check if any placemarks were found
        if (placemarks && placemarks.count > 0)
        {
            CLPlacemark *placemark = placemarks[0];
            
            // Dictionary containing address information
            CNPostalAddress *postalAddress =
            placemark.postalAddress;
            
            NSString *completeAddress = [[NSString alloc] initWithFormat:@"%@ %@", postalAddress.street, postalAddress.city];
            [self.addressLabel setText:completeAddress];
        }
    }];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [mapView setRegion:mapRegion animated: YES];
    
    CLLocationCoordinate2D noLocation = self.locationManager.location.coordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 800, 800);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    [self setAddressForLocation:userLocation.location];
}
    




@end
