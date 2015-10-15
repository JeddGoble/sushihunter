//
//  FirstViewController.m
//  SushiHunter
//
//  Created by Jedd Goble on 10/14/15.
//  Copyright © 2015 Mobile Makers. All rights reserved.
//

#import "FirstViewController.h"
#import "SushiJoint.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationHandler.h"
#import "ShopHandler.h"

@interface FirstViewController () <CLLocationManagerDelegate, MKMapViewDelegate, LocationHandlerDelegate>

@property (strong, nonatomic) NSArray *allShops;
@property (strong, nonatomic) NSArray *sushiJoints;
@property (strong, nonatomic) ShopHandler *shopHandler;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[LocationHandler getSharedInstance] setDelegate:self];
    [[LocationHandler getSharedInstance] startUpdating];
    self.shopHandler = [[ShopHandler alloc] init];
    
    self.mapView.delegate = self;
    
    self.mapView.showsUserLocation = YES;
    
}


- (void) didUpdateToLocation:(CLLocation *)newLocation fromOldLocation:(CLLocation *)oldLocation {
    
}

- (void)updateUserLocation:(CLLocation *)location {
    
    CLLocationCoordinate2D userLocation = [location coordinate];
    
    MKCoordinateSpan coordinateSpan;
    coordinateSpan.latitudeDelta = 0.3;
    coordinateSpan.longitudeDelta = 0.3;
    
    MKCoordinateRegion region;
    region.center = userLocation;
    region.span = coordinateSpan;
    
    [self.mapView setRegion:region animated:YES];
}

- (void) updateShopsArray:(NSArray *)shopsArray {
    self.allShops = [[NSArray alloc] initWithArray:shopsArray];
    
    self.sushiJoints = [[NSArray alloc] initWithArray:[self.shopHandler unPackMapItems:shopsArray]];
    
    
    if (self.sushiJoints.count >= 4) {
        for (int i = 0; i < 4; i++) {
            [self addPinToMap:[self.sushiJoints objectAtIndex:i]];
        }
    } else {
        for (SushiJoint *shop in self.sushiJoints) {
            [self addPinToMap:shop];
        }
    }
    
    LocationHandler *handler = [LocationHandler new];
    [handler stopUpdating];
    
    
}

- (void) addPinToMap:(SushiJoint *)shop {
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = CLLocationCoordinate2DMake(shop.latitude, shop.longitude);
    annotation.title = shop.name;
    [self.mapView addAnnotation:annotation];
    
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    
    if ([annotation isEqual:mapView.userLocation]) {
        return nil;
    }
    
    pin.image = [UIImage imageNamed:@"sushipin"];
    pin.canShowCallout = YES;
    
    pin.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [pin.leftCalloutAccessoryView sizeToFit];
    
    return pin;
    
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    CLLocationCoordinate2D centerCoordinate = view.annotation.coordinate;
    
    MKCoordinateSpan coordinateSpan;
    coordinateSpan.latitudeDelta = 0.1;
    coordinateSpan.longitudeDelta = 0.1;
    
    MKCoordinateRegion region;
    region.center = centerCoordinate;
    region.span = coordinateSpan;
    
    [self.mapView setRegion:region animated:YES];
    
    
}



- (void)failedWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Could not find your location. Try again later." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *bummer = [UIAlertAction actionWithTitle:@"Bummer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:bummer];
}


@end
