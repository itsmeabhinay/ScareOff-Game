//
//  GameViewController.h
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 9/27/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "GameOverDelegate.h"

@interface GameViewController : UIViewController <GameOverDelegate>

@property int score;

@end
