//
//  Component.h
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define componenttype_hull 1
#define componenttype_shield 2
#define componenttype_weapon 3

@interface Component : NSObject

@property (nonatomic, readwrite) int type;
@property (nonatomic, readwrite) int hp;
@property (nonatomic, readwrite) int attack;
@property (nonatomic, readwrite) int recovery;
@property (nonatomic, readwrite) int color1;
@property (nonatomic, readwrite) int color2;
@property (nonatomic, retain) CCSprite * sprite;

- (id) initWithType:(int)type hp:(int)hp attack:(int)attack color1:(int)color1 color2:(int)color2 filename:(NSString*)filename;

@end
