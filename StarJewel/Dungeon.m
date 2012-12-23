//
//  Dungeon.m
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import "Dungeon.h"

@implementation Room

- (id) initWithEnemies:(NSMutableArray *)enemies andBackdropFilename:(NSString *)filename
{
    if ((self = [super init]))
    {
        self.enemies = enemies;
        self.backdrop = [[CCSprite alloc] initWithFile:filename];
    }
    return self;
}

@end

@implementation Dungeon

- (id) initWithRooms:(NSMutableArray *)rooms
{
    if ((self = [super init]))
    {
        self.rooms = rooms;
    }
    return self;
}

@end
