//
//  MapSampleViewController.h
//  TextFieldMap
//
//  Created by Jean Aparecido Chaves da Rocha on 05/02/14.
//  Copyright (c) 2014 Jean Rocha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ResultsTableViewController.h"

@interface MapSampleViewController : UIViewController
<MKMapViewDelegate>

@property (strong, nonatomic) NSMutableArray *matchingItems;
@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)zoomIn:(id)sender;
- (IBAction)changeMapType:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end