//
//  ThirdViewController.m
//  SushiHunter
//
//  Created by Jedd Goble on 10/14/15.
//  Copyright © 2015 Mobile Makers. All rights reserved.
//

#import "ThirdViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "SushiJoint.h"
#import "LocationHandler.h"
#import "ShopHandler.h"
#import "DetailViewController.h"

@interface ThirdViewController () <UITableViewDataSource, UITableViewDelegate, LocationHandlerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *sushiJoints;
@property (strong, nonatomic) ShopHandler *shopHandler;
@property (strong, nonatomic) CLLocation *userLocation;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shopHandler = [[ShopHandler alloc] init];
    [[LocationHandler getSharedInstance] setDelegate:self];
    [[LocationHandler getSharedInstance] startUpdating];
    
    
}

- (void)updateShopsArray:(NSArray *)shopsArray {
    
    self.sushiJoints = [self.shopHandler unPackMapItems:[[NSArray alloc] initWithArray:shopsArray]];
    
    
    
    [self.tableView reloadData];
    
    LocationHandler *handler = [LocationHandler new];
    [handler stopUpdating];
    
}

- (void)updateUserLocation:(CLLocation *)location {
    
    self.userLocation = location;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    if (self.sushiJoints.firstObject) {
        SushiJoint *shop = [self.sushiJoints objectAtIndex:indexPath.row];
        
        cell.textLabel.text = shop.name;
        
        
        CLLocation *shopLocation = [[CLLocation alloc] initWithLatitude:shop.latitude longitude:shop.longitude];
        
        CLLocationDistance meters = [self.userLocation distanceFromLocation:shopLocation];
        
        double miles = meters / 1609.344;
        
        shop.distance = miles;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.02f miles", miles];
    }

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.sushiJoints.count >= 4) {
        return 4;
    } else {
        return 0;
    }
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *tempVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    tempVC.sushiJoint = [self.sushiJoints objectAtIndex:indexPath.row];
    
    
}

- (void)failedWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Could not find your location. Try again later." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *bummer = [UIAlertAction actionWithTitle:@"Bummer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:bummer];
}



@end
