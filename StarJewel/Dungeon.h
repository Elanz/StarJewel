//
//  Dungeon.h
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Room : NSObject

@property (nonatomic, retain) NSMutableArray * enemies;
@property (nonatomic, retain) CCSprite * backdrop;

- (id) initWithEnemies:(NSMutableArray*)enemies andBackdropFilename:(NSString*)filename;

@end

@interface Dungeon : NSObject

@property (nonatomic, retain) NSMutableArray * rooms;

- (id) initWithRooms:(NSMutableArray*)rooms;

@end
