//
//  GameOverScene.h
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 10/20/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameOverDelegate.h"

@interface GameOverScene : SKScene

-(id)initWithSize:(CGSize)size won:(BOOL)won score:(int)score;
@property (weak, nonatomic) id <GameOverDelegate> gameOverDelegate;

@end
