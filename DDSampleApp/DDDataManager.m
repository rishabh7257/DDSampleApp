//
//  DDDataManager.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/16/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDDataManager.h"

NSString * const DDBaseUrl = @"https://api.doordash.com/";

@implementation DDDataManager

- (void)fetchRestaurantsData:(CLLocationCoordinate2D) coordinate {
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@v1/store_search/?lat=%f&lng=%f",DDBaseUrl, coordinate.latitude, coordinate.longitude];
    
    NSLog(urlString);
}

@end
