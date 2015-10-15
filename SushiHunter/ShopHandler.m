//
//  ShopHandler.m
//  SushiHunter
//
//  Created by Jedd Goble on 10/14/15.
//  Copyright © 2015 Mobile Makers. All rights reserved.
//

#import "ShopHandler.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SushiJoint.h"

@implementation ShopHandler

- (NSArray *) unPackMapItems:(NSArray *)mapItems {
    
    NSMutableArray *tempArray = [NSMutableArray new];
    
    for (MKMapItem *place in mapItems) {
        SushiJoint *shop = [SushiJoint new];
        shop.fullMapItem = place;
        
        NSDictionary *shopDict = place.placemark.addressDictionary;
        shop.name = shopDict[@"Name"];
        shop.thoroughfare = shopDict[@"Street"];
        shop.city = shopDict[@"City"];
        shop.state = shopDict[@"State"];
        shop.zipCode = shopDict[@"ZIP"];
        shop.country = shopDict[@"Country"];
        
        shop.latitude = place.placemark.location.coordinate.latitude;
        shop.longitude = place.placemark.location.coordinate.longitude;
        
        shop.phoneNumber = place.phoneNumber;
        shop.url = place.url;
        
        [tempArray addObject:shop];
        
    }
    
    return tempArray;
    
}

@end