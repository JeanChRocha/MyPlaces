//
//  TextFieldViewController.m
//  TextFieldMap
//
//  Created by Jean Aparecido Chaves da Rocha on 04/02/14.
//  Copyright (c) 2014 Jean Rocha. All rights reserved.
//

#import "TextFieldViewController.h"
#import "ResultsTableCell.h"
#import "ResultsTableViewController.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController

//@synthesize destination;

- (void)viewDidLoad
{
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    
    [locationManager startUpdatingLocation];
    
    
       _worldmap.showsUserLocation = YES;
        MKUserLocation *userLocation = _worldmap.userLocation;
    
        MKCoordinateRegion region =
        MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate,
                                           20000, 20000);
    
        [_worldmap setRegion:region animated:YES];
        _worldmap.delegate = self;
        [self getDirections];
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleGesture:)];
    lpgr.minimumPressDuration = 1.0;  //user must press for 2 seconds
    [_worldmap addGestureRecognizer:lpgr];
    //[lpgr release];
    
    
    
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:_worldmap];
    CLLocationCoordinate2D touchMapCoordinate =
    [_worldmap convertPoint:touchPoint toCoordinateFromView:_worldmap];
    
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = touchMapCoordinate;
    //pa.title = item.name;
    [_worldmap addAnnotation:pa];
    [self getDirections];
    //[pa release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _mapItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"resultCell";
    ResultsTableCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                    forIndexPath:indexPath];
    
    long row = [indexPath row];
    
    MKMapItem *item = _mapItems[row];
    
    cell.nameLabel.text = item.name;
    cell.phoneLabel.text = item.phoneNumber;
    
    return cell;
}


- (void)getDirections
{
    MKDirectionsRequest *request =
    [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    request.destination = _destination;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle error
         } else {
             [self showRoute:response];
         }
     }];
}


-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [_worldmap
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}


- (MKOverlayRenderer *)mapView:(MKMapView *) _routeMap rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}


-(void) locationManager:(CLLocationManager *) manager didUpdateLocations:(NSArray *)locations
{
    //    //NSLog(@"%@", [locations lastObject]);
    CLLocationCoordinate2D loc = [[locations lastObject] coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 100, 1000);
    //    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, -23.547356, -46.65161);
    [_worldmap setRegion:region animated:YES];
    [_worldmap setShowsUserLocation:YES];
    //[_worldmap setShowsBuildings:YES];
    [locationManager stopUpdatingLocation];
    
    [_worldmap setMapType:MKMapTypeStandard];
    
    
}


-(void) locationManager:(CLLocationManager *) manager didFailWithError:(NSError *)error
{
    //tratar erro
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_meuTexto resignFirstResponder];
    return TRUE;
}


- (IBAction)btnBuscar:(id)sender {

    
    [sender resignFirstResponder];
    [_worldmap removeAnnotations:[_worldmap annotations]];
    [self performSearch];
    
    [_meuTexto resignFirstResponder];
}




- (IBAction)btnMapa:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [_worldmap setMapType:MKMapTypeStandard];
            break;
        case 1:
            [_worldmap setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [_worldmap setMapType:MKMapTypeHybrid];
            break;
            
        default:
            break;
    }
}


- (void) performSearch {
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = _meuTexto.text;
    request.region = _worldmap.region;
    
    _matchingItems = [[NSMutableArray alloc] init];
    
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
            for (MKMapItem *item in response.mapItems)
            {
                [_matchingItems addObject:item];
                MKPointAnnotation *annotation =
                [[MKPointAnnotation alloc]init];
                annotation.coordinate = item.placemark.coordinate;
                annotation.title = item.name;
                [_worldmap addAnnotation:annotation];
            }
    }];
}





- (IBAction)actTexto:(id)sender {
    
        [sender resignFirstResponder];
        [_worldmap removeAnnotations:[_worldmap annotations]];
        [self performSearch];
    
}

- (IBAction)Current:(id)sender {
    
    [locationManager startUpdatingLocation];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ResultsTableViewController *destination =
    [segue destinationViewController];
    
    destination.mapItems = _matchingItems;
}

@end
