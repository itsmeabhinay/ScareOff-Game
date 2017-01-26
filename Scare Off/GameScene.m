//
//  GameScene.m
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 9/27/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"

@interface GameScene () <SKPhysicsContactDelegate>

@property (nonatomic) SKSpriteNode * backGround;
@property (nonatomic) SKEmitterNode * particleEffect;
@property (nonatomic) SKLabelNode * scoreLabel;
@property (nonatomic) NSTimeInterval lastSpawnTimeIntervalForGreen;
@property (nonatomic) NSTimeInterval lastUpdateTimeIntervalForGreen;
@property (nonatomic) int actualXForGreen;
@property (nonatomic) int actualXForRed;
@property (nonatomic) int crowsAdded;
@property (nonatomic) int redCrowsAdded;
@property (nonatomic) int redCrowsDestroyed;
@property (nonatomic) int crowsDestroyed;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.backGround = [SKSpriteNode spriteNodeWithImageNamed:@"background_field_image"];
        self.backGround.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        [self addChild:self.backGround];
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        self.scoreLabel = [[SKLabelNode alloc] init];
        self.scoreLabel.position = CGPointMake(100, 350);
        self.scoreLabel.fontSize = 20;
        self.scoreLabel.fontName = @"Chalkduster";
        self.scoreLabel.fontColor = [SKColor blackColor];
        
        [self addChild:self.scoreLabel];
    }
    
    return self;
}

- (void)addRedCrow {
    
    // Create sprite
    SKSpriteNode * redCrow = [SKSpriteNode spriteNodeWithImageNamed:@"red_crow_final_image"];
    
    redCrow.name = @"red crow";
    redCrow.userInteractionEnabled = NO;
    
    // Determine where to spawn the monster along the Y axis
    int minX = redCrow.size.width;
    int maxX = self.frame.size.width - redCrow.size.width;
    int rangeX = maxX - minX;
    self.actualXForRed = (arc4random() % rangeX) + minX;
    
    if (self.actualXForRed == self.actualXForGreen || (self.actualXForRed - self.actualXForGreen) < 5) {
        //do nothing
    }
    else {
        redCrow.position = CGPointMake(self.actualXForRed, self.frame.size.height/2);
        [self addChild:redCrow];
        self.crowsAdded++;
        self.redCrowsAdded++;
    }
    
    // remove crow after maxDuration
    int maxDuration = 0;
    
    if (self.crowsAdded <= 5) {
        maxDuration = 1.5;
    }
    else if (self.crowsAdded > 5 && self.crowsAdded < 10) {
        maxDuration = 1;
    }
    else if (self.crowsAdded >= 10) {
        maxDuration = 1;
    }
    
    [redCrow runAction:
                    [SKAction sequence:
                    @[[SKAction waitForDuration:maxDuration],
                    [SKAction runBlock:^{
                                        [self removeChildrenInArray:@[redCrow]];
                                        }
                    ]]
    ]];
    
}

- (void)addGreenCrow {
    
    // Create sprite
    SKSpriteNode * greenCrow = [SKSpriteNode spriteNodeWithImageNamed:@"green_crow_final_image"];
    
    greenCrow.name = @"green crow";
    greenCrow.userInteractionEnabled = NO;
    
    // Determine where to spawn the monster along the X axis
    int minX = greenCrow.size.width / 6;
    int maxX = self.frame.size.width - greenCrow.size.width / 6;
    int rangeX = maxX - minX;
    self.actualXForGreen = (arc4random() % rangeX) + minX;
    
    if (self.actualXForRed == self.actualXForGreen || (self.actualXForRed - self.actualXForGreen) < 5) {
        //do nothing
    }
    else {
        greenCrow.position = CGPointMake(self.actualXForGreen, self.frame.size.height/2);
        
        [self addChild:greenCrow];
        self.crowsAdded++;
    }
    
    // remove crow after maxDuration
    int maxDuration = 0;
    
    if (self.crowsAdded <= 5) {
        maxDuration = 1.5;
    }
    else if (self.crowsAdded > 5 && self.crowsAdded < 10) {
        maxDuration = 1;
    }
    else if (self.crowsAdded >= 10) {
        maxDuration = 1;
    }
    
    [greenCrow runAction:
                        [SKAction sequence:
                        @[[SKAction waitForDuration:maxDuration],
                          [SKAction runBlock:^{
                                            [self removeChildrenInArray:@[greenCrow]];
                                            }
                        ]]
    ]];
}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeIntervalForGreen;
    self.lastUpdateTimeIntervalForGreen = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeIntervalForGreen = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

#pragma mark - private methods
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeIntervalForGreen += timeSinceLast;
    
    double timeForAddingCrow = 0;
    
    if (self.redCrowsDestroyed + 2 < self.redCrowsAdded) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO score:self.crowsDestroyed];
        [self.view presentScene:gameOverScene transition: reveal];
    }
    
    if (self.crowsAdded <= 5) {
        timeForAddingCrow = 1.2;
    }
    else if (self.crowsAdded > 5 && self.crowsAdded <= 15) {
        timeForAddingCrow = 1;
    }
    else if (self.crowsAdded > 15) {
        timeForAddingCrow = 0.6;
    }
    
    if (self.lastSpawnTimeIntervalForGreen > timeForAddingCrow) {
        self.lastSpawnTimeIntervalForGreen = 0;
        
        int randomCrow = arc4random_uniform(2);
        switch (randomCrow) {
            case 0:
                [self addGreenCrow];
                break;
            case 1:
                [self addRedCrow];
                break;
            default:
                break;
        }
    }
}

#pragma mark - touch methods
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touchNode = [self nodeAtPoint:location];
    
    NSString *name = touchNode.name;
    
//    if ([name isEqualToString:@"red crow"] ||
//        [name isEqualToString:@"green crow"])
    if ([name isEqualToString:@"red crow"]) {
        
        self.crowsDestroyed++;
        self.redCrowsDestroyed++;
        [self removeChildrenInArray:@[touchNode]];
        [self addScore:self.crowsDestroyed];
    }
    else {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO score:self.crowsDestroyed];
        [self.view presentScene:gameOverScene transition: reveal];
    }
}

#pragma mark - emitter node methods
- (SKEmitterNode *) newExplosion: (float)posX : (float) posY
{
    SKEmitterNode *emitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticleEmitter" ofType:@"sks"]];
    emitter.position = CGPointMake(posX,posY);
    emitter.name = @"explosion";
    emitter.targetNode = self.scene;
    return emitter;
}

-(void)addScore:(int)score {
     self.scoreLabel.text = [NSString stringWithFormat:@"Your Score: %d", score];
}

@end
