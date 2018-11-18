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

- (void)fetchRestaurantsData:(CLLocation *) location {
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@v1/store_search/?lat=%f&lng=%f",DDBaseUrl, location.coordinate.latitude, location.coordinate.longitude];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:urlString]];
    
    __weak __typeof(self) weakSelf = self;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *erro = nil;
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSMutableArray<DDRestaurantModel *> *exploreData = [weakSelf parseDictionary:responseArray];
            [self.delegate fetchRestaurantsDataFinishWithSuccess:exploreData];
        } else {
            // Log a metric here.
        }
        dispatch_sync(dispatch_get_main_queue(),^{
            
            
        });
    }] resume] ;
}

- (NSMutableArray<DDRestaurantModel *> *)parseDictionary:(NSArray *)serverResponse {
    NSMutableArray<DDRestaurantModel *> *exploreData = [NSMutableArray new];
    for (NSDictionary* dict in serverResponse) {
        DDRestaurantModel *model = [DDRestaurantModel new];
        model.shortDescription = [dict objectForKey:@"description"];
        model.cover_img_url = [dict objectForKey:@"cover_img_url"];
        model.name = [dict objectForKey:@"name"];
        model.status = [dict objectForKey:@"status"];
        CGFloat deliveryFee = [[dict objectForKey:@"delivery_fee"] floatValue];
        
        NSString *formattedDeliveryFee = deliveryFee == 0 ? @"Free Delivert" : [NSString stringWithFormat:@"$ %.02f delivery", deliveryFee];
        model.delivery_fee = formattedDeliveryFee;
        [exploreData addObject:model];
    }
    return exploreData;
}

@end
