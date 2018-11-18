//
//  DDExploreTableViewCell.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDExploreTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DDExploreTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *restaurantDescription;
@property (weak, nonatomic) IBOutlet UILabel *deliveryFees;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

@implementation DDExploreTableViewCell

- (void)setContent:(DDRestaurantModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_img_url]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.name.text = model.name;
    self.restaurantDescription.text = model.shortDescription;
    self.deliveryFees.text = model.delivery_fee;
    self.status.text = model.status;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.name = nil;
    self.logoImageView = nil;
    self.restaurantDescription = nil;
    self.deliveryFees = nil;
    self.status = nil;
}
@end
