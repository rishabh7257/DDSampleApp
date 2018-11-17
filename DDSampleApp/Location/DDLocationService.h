//
//  DDLocationService.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDLocationService <NSObject>

- (void)enableLocation;

- (BOOL)isLocationServiceEnable;

- (void)currentUserLocation;

- (void)currentUserFriendlyAddress:(CLLocation *)location
                      processBlock:(void (^)(NSString *address))processBlock;
@end
