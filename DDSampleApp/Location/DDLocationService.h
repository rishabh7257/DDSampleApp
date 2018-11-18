//
//  DDLocationService.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>

@protocol DDLocationService <NSObject>

- (void)enableLocation;

- (BOOL)isLocationServiceEnable;

- (CLLocation *)currentUserLocation;

- (void)forceRequestLocation;

- (void)currentUserFriendlyAddress:(CLLocation *)location
                      processBlock:(void (^)(NSString *address))processBlock;
@end
