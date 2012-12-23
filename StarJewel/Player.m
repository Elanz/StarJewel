//
//  Player.m
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import "Player.h"
#import "Component.h"

static Player * _sharedPlayer;

@implementation Player

+ (Player*) sharedPlayer
{
    @synchronized(self) {
        if (_sharedPlayer == nil)
        {
            _sharedPlayer = [[self alloc] init];
        }
    }
    return _sharedPlayer;
}

- (int) computeHp
{
    return self.hull.hp + self.slot1.hp + self.slot2.hp + self.slot3.hp + self.slot4.hp;
}

@end
