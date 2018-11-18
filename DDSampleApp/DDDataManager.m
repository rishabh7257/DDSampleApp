//
//  DDDataManager.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/16/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDDataManager.h"

NSString * const DDBaseUrl = @"https://api.doordash.com/";
NSString * const DDUrlFormat = @"%@v1/store_search/?lat=%f&lng=%f";

@implementation DDDataManager

- (void)fetchRestaurantsData:(CLLocation *) location {
    NSString *urlString = [[NSString alloc] initWithFormat:DDUrlFormat, DDBaseUrl, location.coordinate.latitude, location.coordinate.longitude];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:urlString]];
    
    __weak __typeof(self) weakSelf = self;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSMutableArray<DDRestaurantModel *> *exploreData = [weakSelf parseDictionary:responseArray];
            [self.delegate fetchRestaurantsDataFinishWithSuccess:exploreData];
        } else {
            // Log a metric here.
        }
    }] resume] ;
}

- (NSMutableArray<DDRestaurantModel *> *)parseDictionary:(NSArray *)serverResponse {
    NSMutableArray<DDRestaurantModel *> *exploreData = [NSMutableArray new];
    for (NSDictionary* dict in serverResponse) {
        DDRestaurantModel *model = [DDRestaurantModel new];
        NSString *shortDescription = [dict objectForKey:@"description"];
        model.shortDescription = [shortDescription componentsSeparatedByString:@","][0];
        model.cover_img_url = [dict objectForKey:@"cover_img_url"];
        model.name = [dict objectForKey:@"business"][@"name"];
        model.status = [dict objectForKey:@"status"];
        CGFloat deliveryFee = [[dict objectForKey:@"delivery_fee"] floatValue]/100;
        
        model.delivery_fee = deliveryFee == 0 ? @"Free Delivery" : [NSString stringWithFormat:@"$ %.02f delivery", deliveryFee];
        [exploreData addObject:model];
    }
    return exploreData;
}

@end
