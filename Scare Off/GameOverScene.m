//
//  GameOverScene.m
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 10/20/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"
#import "GameViewController.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size won:(BOOL)won score:(int)score {
    
    if (self = [super initWithSize:size]) {
        
        //self.gameOverDelegate = self;
        
        // 1
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        // 2
        NSString * message;
        if (won) {
            message = @"You Won!";
        } else {
            message = [NSString stringWithFormat:@"Sorry, Try Again.\r Your Score is: %d", score];
        }
        
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 30;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        // 4
        [self runAction:
         [SKAction sequence:@[
                              [SKAction waitForDuration:3.0],
                              [SKAction runBlock:^{
             // 5
             GameViewController *game = [[GameViewController alloc] init];
             self.gameOverDelegate = game;
             [game navigateToLastViewWithScore:score];
         }]
                              ]]
         ];
        
    }
    return self;

}

@end
