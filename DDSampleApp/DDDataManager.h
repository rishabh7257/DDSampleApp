//
//  DDDataManager.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/16/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface DDDataManager : NSObject

- (void)fetchRestaurantsData:(CLLocationCoordinate2D) coordinate;

@end
