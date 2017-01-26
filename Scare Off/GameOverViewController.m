//
//  GameOverViewController.m
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 12/5/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation GameOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Your score is %d", self.Score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
