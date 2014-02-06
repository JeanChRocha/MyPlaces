//
//  TextFieldViewController.h
//  TextFieldMap
//
//  Created by Jean Aparecido Chaves da Rocha on 04/02/14.
//  Copyright (c) 2014 Jean Rocha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ResultsTableViewController.h"

//#import <UIKit/UIKit.h>
//#import <MapKit/MapKit.h>
//#import "ResultsTableCell.h"
//#import "RouteViewController.h"
//
//@interface ResultsTableViewController : UITableViewController
//@property (strong, nonatomic) NSArray *mapItems;
//@end




@interface TextFieldViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
}

//@property (strong, nonatomic) IBOutlet MKMapView *routeMap;

@property (strong, nonatomic) MKMapItem *destination;

@property (strong, nonatomic) NSArray *mapItems;

@property (strong, nonatomic) NSMutableArray *matchingItems;

@property (weak, nonatomic) IBOutlet MKMapView *worldmap;

- (IBAction)Current:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *meuTexto;

- (IBAction)btnBuscar:(id)sender;


- (IBAction)btnMapa:(UISegmentedControl *)sender;

- (IBAction)actTexto:(id)sender;

@end
