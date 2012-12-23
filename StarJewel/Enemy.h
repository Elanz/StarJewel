//
//  Enemy.h
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : NSObject

@property (nonatomic, readwrite) int hp;
@property (nonatomic, readwrite) int attack;
@property (nonatomic, readwrite) int turnsBetweenAttacks;
@property (nonatomic, readwrite) int width;
@property (nonatomic, readwrite) int color;
@property (nonatomic, retain) CCSprite * sprite;
@property (nonatomic, retain) CCSprite * hpBar_bkgd;
@property (nonatomic, retain) CCProgressTimer * hpBar;

- (id) initWithHp:(int)hp attack:(int)attack turnsBetweenAttacks:(int)turnsBetweenAttacks width:(int)width color:(int)color filename:(NSString*)filename;

@end
