//
//  DDLocationServiceImpl.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDLocationServiceImpl.h"
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

@class CLPlacemark;

@interface DDLocationServiceImpl ()

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLGeocoder *geocoder;


@end

@implementation DDLocationServiceImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _geocoder = [CLGeocoder new];

    }
    return self;
}

#pragma mark - DDLocationService

- (NSString *)currentUserFriendlyAddress {
    return @"";
}

- (void)currentUserFriendlyAddress:(CLLocation *)location
               processBlock:(void (^)(NSString *address))processBlock {
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return; // Request failed, log error
        }
        
        // Check if any placemarks were found
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            
            NSString *completeAddress = [[NSString alloc] initWithFormat:@"%@ %@", placemark.subThoroughfare, placemark.thoroughfare];
            processBlock(completeAddress);
        }
    }];
}

- (BOOL)isLocationServiceEnable {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            return NO;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return YES;
        default:
            break;
    }
    return NO;
}

- (void)enableLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self locationIsDenied];
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self locationGranted];
        default:
            break;
    }
}

- (CLLocation *)currentUserLocation {
    return self.locationManager.location;
}


#pragma mark - PrivateMethods

- (void)locationIsDenied {
    // Stub method in case we need to take any action here.
}

- (void)locationGranted {
    // Stub method in case need to take any action here.
}

@end
