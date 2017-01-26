//
//  GameOverDelegate.h
//  Scare Off
//
//  Created by Abhinay Simha Vangipuram on 12/5/16.
//  Copyright © 2016 Home. All rights reserved.
//

@protocol GameOverDelegate <NSObject>

- (void)navigateToLastViewWithScore:(int)score;

@end
