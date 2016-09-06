//
//  ViewController.h
//  Maps
//
//  Created by Student P_03 on 06/09/16.
//  Copyright © 2016 AkshayAwtade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/MapKit.h>
#import <corelocation/coreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *location;
    CLLocation *presentLocation;
}

@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControllerMap;
- (IBAction)segmentControllerMapValueChanged:(id)sender;

@end

