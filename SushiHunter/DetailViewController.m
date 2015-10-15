//
//  DetailViewController.m
//  SushiHunter
//
//  Created by Jedd Goble on 10/15/15.
//  Copyright © 2015 Mobile Makers. All rights reserved.
//

#import "DetailViewController.h"
#import "SushiJoint.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *milesLabel;
@property (strong, nonatomic) IBOutlet UITextView *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    self.titleLabel.text = self.sushiJoint.name;
    self.milesLabel.text = [NSString stringWithFormat:@"%.02f Miles", self.sushiJoint.distance];
    self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@ %@ %@", self.sushiJoint.thoroughfare, self.sushiJoint.city, self.sushiJoint.state, self.sushiJoint.zipCode];
    self.phoneLabel.text = self.sushiJoint.phoneNumber;

}

- (IBAction)dismissButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
