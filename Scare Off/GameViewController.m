//
//  GameViewController.m
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 9/27/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "GameOverViewController.h"
#import "GameOverScene.h"

@implementation GameViewController 

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = NO;
        skView.showsNodeCount = NO;
        
        // Create and configure the scene.
        SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
    
    GameOverScene *gameOver = [[GameOverScene alloc] init];
    gameOver.gameOverDelegate = self;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)navigateToLastViewWithScore:(int)score {
    self.score = score;
    [self performSegueWithIdentifier:@"gameOverSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"gameOverSegue"]) {
        GameOverViewController *gameOver = [segue destinationViewController];
        gameOver.Score = self.score;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
