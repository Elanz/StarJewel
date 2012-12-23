//
//  Enemy.m
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

- (id) initWithHp:(int)hp attack:(int)attack turnsBetweenAttacks:(int)turnsBetweenAttacks width:(int)width color:(int)color filename:(NSString*)filename
{
    if ((self = [super init]))
    {
        self.hp = hp;
        self.attack = attack;
        self.turnsBetweenAttacks = turnsBetweenAttacks;
        self.width = width;
        self.color = color;
        self.sprite = [[CCSprite alloc] initWithFile:filename];
        NSString * hpBarPrefix;
        switch (width) {
            case 50: hpBarPrefix = @"e100x_"; break;
            case 75: hpBarPrefix = @"e150x_"; break;
            case 100: hpBarPrefix = @"e200x_"; break;
            case 125: hpBarPrefix = @"e250x_"; break;
            case 250: hpBarPrefix = @"e500x_"; break;
            default:
                break;
        }
        NSString * hpBarSuffix;
        switch (color) {
            case color_blue: hpBarSuffix = @"blue"; break;
            default:
                break;
        }
        self.hpBar_bkgd = [[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"hpbars/%@hp_bkgd.png", hpBarPrefix]];
        self.hpBar = [CCProgressTimer progressWithSprite:[[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"hpbars/%@hp_%@.png", hpBarPrefix, hpBarSuffix]]];
        self.hpBar.type = kCCProgressTimerTypeBar;
        self.hpBar.percentage = 100;
    }
    return self;
}

@end
