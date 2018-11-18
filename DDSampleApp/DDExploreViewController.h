//
//  DDExploreViewController.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DDRestaurantModel.h"

@interface DDExploreViewController : UIViewController

@property (nonatomic) CLLocation *location;
@property (nonatomic) NSArray<DDRestaurantModel *> *dataSource;

@end
