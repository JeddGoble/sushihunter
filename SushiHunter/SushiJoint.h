//
//  SushiJoint.h
//  SushiHunter
//
//  Created by Jedd Goble on 10/14/15.
//  Copyright © 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKMapItem;

@interface SushiJoint : NSObject

@property (strong, nonatomic) MKMapItem *fullMapItem;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *subThoroughfare;
@property (strong, nonatomic) NSString *thoroughfare;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *phoneNumber;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSURL *url;


@end
