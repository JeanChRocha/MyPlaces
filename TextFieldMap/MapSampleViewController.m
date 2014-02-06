//
//  MapSampleViewController.m
//  TextFieldMap
//
//  Created by Jean Aparecido Chaves da Rocha on 05/02/14.
//  Copyright (c) 2014 Jean Rocha. All rights reserved.
//

#import "MapSampleViewController.h"

@interface MapSampleViewController ()

@end

@implementation MapSampleViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ResultsTableViewController *destination =
    [segue destinationViewController];
    
    destination.mapItems = _matchingItems;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
