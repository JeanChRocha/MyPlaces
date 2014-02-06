//
//  RouteViewController.h
//  TextFieldMap
//
//  Created by Arturo Sekijima on 06/02/14.
//  Copyright (c) 2014 Jean Rocha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RouteViewController : UIViewController <MKMapViewDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *routeMap;
@property (strong, nonatomic) MKMapItem *destination;

@end
