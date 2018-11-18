//
//  DDExploreViewController.m
//  DDSampleApp
//
//  Created by Rishabh Sanghvi on 11/17/18.
//  Copyright © 2018 Rishabh Sanghvi. All rights reserved.
//

#import "DDExploreViewController.h"
#import "DDDataManager.h"
#import "DDExploreTableViewCell.h"

@interface DDExploreViewController () <UITableViewDelegate, UITableViewDataSource, DDDataManagerListner>

@property (nonatomic) DDDataManager *dataManager;
@property (nonatomic) UITableView *tableView;

@end

@implementation DDExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    self.dataManager = [DDDataManager new];
    [self.dataManager fetchRestaurantsData:self.location];
    self.dataManager.delegate = self;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = self.view.frame;
    [self.tableView registerNib:[UINib nibWithNibName:@"DDExploreTableCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDExploreTableViewCell *cell = (DDExploreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    [cell setContent:self.dataSource[indexPath.row]];
    return cell;    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)fetchRestaurantsDataFinishWithFailure {
    // log a metric
}

- (void)fetchRestaurantsDataFinishWithSuccess:(NSArray<DDRestaurantModel *> *)data {
    dispatch_sync(dispatch_get_main_queue(),^{
        self.dataSource = [data copy];
        [self.tableView reloadData];
    });
}


@end
