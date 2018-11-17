//
//  DDMapViewViewController.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol DDUserSelectedLocationListner

- (void)userDidSelectLocation:(CLLocation *)location;

@end

@interface DDMapViewViewController : UIViewController

- (void)mapTapAction:(UITapGestureRecognizer *)tapGestureRecognizer
  processBlock:(void (^)(NSString *address))processBlock;

@property (nonatomic, weak) id<DDUserSelectedLocationListner> delegate;

@end
