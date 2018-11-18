//
//  DDExploreTableViewCell.h
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DDRestaurantModel.h"

@interface DDExploreTableViewCell : UITableViewCell

- (void)setContent:(DDRestaurantModel *)model;

@end
