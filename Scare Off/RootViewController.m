//
//  RootViewController.m
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 11/21/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"startGameSegue" sender:self];
}

@end
