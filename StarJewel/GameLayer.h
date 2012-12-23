//
//  GameLayer.h
//  StarJewel
//
//  Created by Eric Lanz on 11/23/12.
//  Copyright 2012 200 Monkeys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Dungeon, Room;

@interface Gem : NSObject

@property (nonatomic, retain) CCSprite * sprite;
@property (nonatomic, readwrite) int color;

@end

@interface GameLayer : CCLayer <CCTouchOneByOneDelegate>
{
    CCSprite * _bkgd;
    CCSprite * _hpBarBkgd;
    Gem * _dragGem;
    Gem * _realDragGem;
    CGPoint _dragOffset;
    NSMutableArray * _gems;
    NSMutableSet *_run, *_tempRun;
    BOOL _allowInput;
    int _howManyToProcess;
    Dungeon * _dungeon;
    Room * _currentRoom;
    CCProgressTimer * _playerHpBar;
    
    int _playerHp;
    int _roomId;
}

- (void) startGameWithDungeon:(Dungeon*)dungeon;

@end
