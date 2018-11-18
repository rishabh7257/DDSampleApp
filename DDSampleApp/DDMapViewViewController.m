//
//  DDMapViewViewController.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDMapViewViewController.h"
#import "DDLocationService.h"
#import "DDLocationServiceImpl.h"

@interface DDMapViewViewController () <MKMapViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLGeocoder *geocoder;
@property (nonatomic) UITapGestureRecognizer *mapTapGesture;
@property (nonatomic) MKPointAnnotation *annotation;
@property (nonatomic) id<DDLocationService> locationService;

@end

@implementation DDMapViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.mapView.userInteractionEnabled = YES;
    [self.view addSubview: self.mapView];
    self.mapView.frame = self.view.frame;
    self.locationService = [DDLocationServiceImpl new];

    self.annotation = [[MKPointAnnotation alloc] init];
    self.geocoder = [CLGeocoder new];
    [self.mapView addAnnotation:self.annotation];

}

- (void)mapTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    CGPoint point = [tapGestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];

    [self.annotation setCoordinate:coordinate];

    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [self.delegate userDidSelectLocation:location];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D currentLocation2D = [self.locationService currentUserLocation].coordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(currentLocation2D, 800, 800);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];

}

@end
