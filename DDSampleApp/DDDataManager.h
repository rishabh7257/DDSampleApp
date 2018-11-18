//
//  DDDataManager.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/16/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DDRestaurantModel.h"


@protocol DDDataManagerListner

- (void)fetchRestaurantsDataFinishWithSuccess:(NSArray<DDRestaurantModel *> *)data;

- (void)fetchRestaurantsDataFinishWithFailure;

@end

@interface DDDataManager : NSObject

- (void)fetchRestaurantsData:(CLLocation *) location;

@property (nonatomic, weak) id<DDDataManagerListner> delegate;

@end
