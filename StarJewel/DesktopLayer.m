//
//  DesktopLayer.m
//  StarJewel
//
//  Created by Eric Lanz on 11/23/12.
//  Copyright 2012 200 Monkeys. All rights reserved.
//

#import "DesktopLayer.h"
#import "GameLayer.h"
#import "Player.h"
#import "Component.h"
#import "Dungeon.h"
#import "Enemy.h"

@implementation DesktopLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DesktopLayer *layer = [DesktopLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) loadPlayer
{
    [Player sharedPlayer].hull = [[Component alloc] initWithType:componenttype_hull hp:100 attack:5 color1:color_purple color2:color_none filename:@"component/hull1.png"];
    [Player sharedPlayer].slot1 = [[Component alloc] initWithType:componenttype_shield hp:200 attack:0 color1:color_green color2:color_none filename:@"component/shield1.png"];
    [Player sharedPlayer].slot2 = [[Component alloc] initWithType:componenttype_weapon hp:50 attack:10 color1:color_red color2:color_none filename:@"component/wep1.png"];
    [Player sharedPlayer].slot3 = [[Component alloc] initWithType:componenttype_weapon hp:50 attack:10 color1:color_blue color2:color_none filename:@"component/wep2.png"];
    [Player sharedPlayer].slot4 = [[Component alloc] initWithType:componenttype_weapon hp:50 attack:10 color1:color_yellow color2:color_none filename:@"component/wep3.png"];
}

-(void) startRound
{
    _gameScene = [CCScene node];
    GameLayer * round = [GameLayer node];
    [_gameScene addChild:round];
    
    NSMutableArray * rooms = [NSMutableArray array];
    NSMutableArray * enemies = [NSMutableArray array];
    [enemies addObject:[[Enemy alloc] initWithHp:100 attack:10 turnsBetweenAttacks:3 width:50 color:color_blue filename:@"enemy/e100_1.png"]];
    [enemies addObject:[[Enemy alloc] initWithHp:100 attack:10 turnsBetweenAttacks:3 width:50 color:color_blue filename:@"enemy/e100_1.png"]];
    [rooms addObject:[[Room alloc] initWithEnemies:enemies andBackdropFilename:@"backdrop/backdrop1.png"]];
    enemies = [NSMutableArray array];
    [enemies addObject:[[Enemy alloc] initWithHp:150 attack:15 turnsBetweenAttacks:3 width:75 color:color_blue filename:@"enemy/e150_1.png"]];
    [enemies addObject:[[Enemy alloc] initWithHp:100 attack:10 turnsBetweenAttacks:2 width:50 color:color_blue filename:@"enemy/e100_1.png"]];
    [enemies addObject:[[Enemy alloc] initWithHp:150 attack:15 turnsBetweenAttacks:3 width:75 color:color_blue filename:@"enemy/e150_1.png"]];
    [rooms addObject:[[Room alloc] initWithEnemies:enemies andBackdropFilename:@"backdrop/backdrop2.png"]];
    enemies = [NSMutableArray array];
    [enemies addObject:[[Enemy alloc] initWithHp:175 attack:20 turnsBetweenAttacks:4 width:100 color:color_blue filename:@"enemy/e200_1.png"]];
    [enemies addObject:[[Enemy alloc] initWithHp:200 attack:25 turnsBetweenAttacks:5 width:125 color:color_blue filename:@"enemy/e250_1.png"]];
    [rooms addObject:[[Room alloc] initWithEnemies:enemies andBackdropFilename:@"backdrop/backdrop1.png"]];
    enemies = [NSMutableArray array];
    [enemies addObject:[[Enemy alloc] initWithHp:500 attack:30 turnsBetweenAttacks:6 width:250 color:color_blue filename:@"enemy/e500_1.png"]];
    [rooms addObject:[[Room alloc] initWithEnemies:enemies andBackdropFilename:@"backdrop/backdrop3.png"]];
    [round startGameWithDungeon:[[Dungeon alloc] initWithRooms:rooms]];

    for (Room * room in rooms)
    {
        NSLog(@" room = %d", room.enemies.count);
    }
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:_gameScene]];
}

-(void) onEnter
{
	[super onEnter];
    [self loadPlayer];
    [self startRound];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return NO;
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {}
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {}

@end
