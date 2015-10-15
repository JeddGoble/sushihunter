//
//  LocationHandler.m
//  SushiHunter
//
//  Created by Jedd Goble on 10/14/15.
//  Copyright © 2015 Mobile Makers. All rights reserved.
//

#import "LocationHandler.h"
#import <MapKit/MapKit.h>

static LocationHandler *DefaultManager = nil;

@interface LocationHandler ()

- (void) initiate;

@end

@implementation LocationHandler

+ (id)getSharedInstance {
    if (!DefaultManager) {
        DefaultManager = [[self allocWithZone:NULL] init];
        [DefaultManager initiate];
    }
    return DefaultManager;
}



- (void)initiate{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
}

- (void)startUpdating{
    [locationManager startUpdatingLocation];
}

- (void) stopUpdating{
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:
(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.delegate failedWithError:error];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations.firstObject;
    [self reverseGeocode:currentLocation];
    [self.delegate updateUserLocation:locations.firstObject];
//    [locationManager stopUpdatingLocation];
}

- (void) reverseGeocode:(CLLocation *)location {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [self findShopNear:location];
    }];
}

- (void) findShopNear:(CLLocation *)location {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"sushi";
    request.region= MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1.0, 1.0));
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        [self.delegate updateShopsArray:response.mapItems];
    }];
}




@end
