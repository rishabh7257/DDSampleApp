//
//  DDRestaurantModel.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDRestaurantModel : NSObject

@property (nonatomic) NSString *cover_img_url; // image url
@property (nonatomic) NSString *name; // Restaurant name, eg. "Curry Up Now"
@property (nonatomic) NSString *shortDescription; // Type of food, eg. Indian
@property (nonatomic) NSString *status; // Delivery Time, eg. 31 min
@property (nonatomic) NSString *delivery_fee; // Deliver Fee, if 0, Free delivery else $4.99 delivery


@end
