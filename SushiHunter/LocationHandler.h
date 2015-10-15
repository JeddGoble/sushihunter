//
//  LocationHandler.h
//  SushiHunter
//
//  Created by Jedd Goble on 10/14/15.
//  Copyright © 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationHandlerDelegate <NSObject>

@required

- (void) failedWithError:(NSError *)error;

- (void) updateShopsArray:(NSArray *)shopsArray;

- (void) updateUserLocation:(CLLocation *)location;

@end


@interface LocationHandler : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) id <LocationHandlerDelegate> delegate;

+ (id)getSharedInstance;
- (void) startUpdating;
- (void) stopUpdating;


@end
