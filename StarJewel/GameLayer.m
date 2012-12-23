//
//  GameLayer.m
//  StarJewel
//
//  Created by Eric Lanz on 11/23/12.
//  Copyright 2012 200 Monkeys. All rights reserved.
//

#import "GameLayer.h"
#import "Player.h"
#import "Dungeon.h"
#import "Component.h"
#import "Enemy.h"

@implementation Gem @end

@implementation GameLayer

-(CCSprite*)createGemWithColor:(int)gemColor
{
    switch (gemColor) {
        case color_purple: return [CCSprite spriteWithFile:@"gui/gem_purple.png"];
        case color_yellow: return [CCSprite spriteWithFile:@"gui/gem_yellow.png"];
        case color_pink: return [CCSprite spriteWithFile:@"gui/gem_pink.png"];
        case color_red: return [CCSprite spriteWithFile:@"gui/gem_red.png"];
        case color_green: return [CCSprite spriteWithFile:@"gui/gem_green.png"];
        case color_blue: return [CCSprite spriteWithFile:@"gui/gem_blue.png"];
        default: return [CCSprite spriteWithFile:@"gui/gem_blue.png"];
    }
}

-(Gem*)createRandomGem
{
    int gemColor = (arc4random() % 6) + 1;
    CCSprite * gem = [self createGemWithColor:gemColor];
    gem.zOrder = 9;
    Gem * container = [[Gem alloc] init];
    container.sprite = gem;
    container.color = gemColor;
    return container;
}

-(void) initBoard
{
    _gems = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i++)
        [_gems addObject:[self createRandomGem]];
    
    float startY = 25.5;
    float startX = 27.5;
    
    for (int y = 0; y < 5; y++)
    {
        for (int x = 0; x < 6; x++)
        {
            int idx = x+(y*6);
            Gem * container = _gems[idx];
            [container.sprite setPosition:CGPointMake(startX, startY)];
            [self addChild:container.sprite];
            startX += 53;
        }
        startY += 53;
        startX = 27.5;
    }
}

-(id) init
{
    if((self=[super init])) {
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:colorLayer z:0];
        
		_bkgd = [CCSprite spriteWithFile:@"gui/game_bkgd.png"];
		_bkgd.position = ccp(size.width/2, (_bkgd.boundingBox.size.height/2.0));
        _bkgd.zOrder = 2;
        
		// add the label as a child to this Layer
		[self addChild:_bkgd];
        [self initBoard];
        
        _run = [[NSMutableSet alloc] init];
        _tempRun = [[NSMutableSet alloc] init];
        _dragGem = nil;
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        _allowInput = YES;
	}
	
	return self;
}

#pragma mark setup

- (void) startGameWithDungeon:(Dungeon*)dungeon
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    _dungeon = dungeon;
    _playerHp = [[Player sharedPlayer] computeHp];
    _playerHpBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"gui/playerHpBar.png"]];
    _playerHpBar.type = kCCProgressTimerTypeBar;
    _playerHpBar.zOrder = 2;
    _playerHpBar.percentage = 100;
    _playerHpBar.position = ccp(size.width/2,270);
    [self addChild:_playerHpBar];
    _hpBarBkgd = [[CCSprite alloc] initWithFile:@"gui/playerHPBar_bkgd.png"];
    _hpBarBkgd.zOrder = 3;
    _hpBarBkgd.position = ccp(size.width/2,270);
    [self addChild:_hpBarBkgd];

    float startX = 27.5;
    float startY = 304;
    
    [Player sharedPlayer].hull.sprite.position = CGPointMake(startX, startY);
    [Player sharedPlayer].hull.sprite.zOrder = 20;
    [self addChild:[Player sharedPlayer].hull.sprite];
    startX += 53;
    if ([Player sharedPlayer].slot1)
    {
        [Player sharedPlayer].slot1.sprite.position = CGPointMake(startX, startY);
        [Player sharedPlayer].slot1.sprite.zOrder = 20;
        [self addChild:[Player sharedPlayer].slot1.sprite];
    }
    startX += 53;
    if ([Player sharedPlayer].slot2)
    {
        [Player sharedPlayer].slot2.sprite.position = CGPointMake(startX, startY);
        [Player sharedPlayer].slot2.sprite.zOrder = 20;
        [self addChild:[Player sharedPlayer].slot2.sprite];
    }
    startX += 53;
    if ([Player sharedPlayer].slot3)
    {
        [Player sharedPlayer].slot3.sprite.position = CGPointMake(startX, startY);
        [Player sharedPlayer].slot3.sprite.zOrder = 20;
        [self addChild:[Player sharedPlayer].slot3.sprite];
    }
    startX += 53;
    if ([Player sharedPlayer].slot4)
    {
        [Player sharedPlayer].slot4.sprite.position = CGPointMake(startX, startY);
        [Player sharedPlayer].slot4.sprite.zOrder = 20;
        [self addChild:[Player sharedPlayer].slot4.sprite];
    }
    
    _roomId = 0;
    [self loadRoom:_dungeon.rooms[_roomId]];
}

-(void) loadRoom:(Room*)room
{
    _currentRoom = room;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    room.backdrop.zOrder = 1;
    room.backdrop.position = CGPointMake(size.width/2.0, 371);
    [self addChild:room.backdrop];
    
    int enemyCount = room.enemies.count;
    int totalEnemyWidth = (enemyCount-1)*6;
    for (Enemy * enemy in room.enemies)
    {
        totalEnemyWidth += enemy.width;
    }
    int startX = (size.width - totalEnemyWidth)/2.0;
    for (Enemy * enemy in room.enemies)
    {
        [self addChild:enemy.sprite];
        enemy.sprite.position = CGPointMake(startX+(enemy.width/2.0), 405);
        enemy.sprite.zOrder = 4;
        enemy.hpBar_bkgd.zOrder = 4;
        enemy.hpBar_bkgd.position = CGPointMake(startX+(enemy.width/2.0), 347);
        [self addChild:enemy.hpBar_bkgd];
        enemy.hpBar.zOrder = 3;
        enemy.hpBar.position = CGPointMake(startX+(enemy.width/2.0), 347);
        [self addChild:enemy.hpBar];
        startX += enemy.width+6;
    }
}

#pragma mark gameplay

-(void)findMatchesAboveGem:(Gem*)gem index:(int)index
{
    int y = index / 6;
    if (y == 0) return;
    else
    {
        [_tempRun addObject:gem];
        int newIndex = index-6;
        Gem * newGem = _gems[newIndex];
        if (newGem.color == gem.color)
        {
            [_tempRun addObject:newGem];
            //NSLog(@"match above, color = %d, newColor = %d, index = %d, newIndex = %d", gem.color, newGem.color, index, newIndex);
            [self findMatchesAboveGem:newGem index:newIndex];
        }
    }
}

-(void)findMatchesBelowGem:(Gem*)gem index:(int)index
{
    int y = index / 6;
    if (y == 4) return;
    else
    {
        [_tempRun addObject:gem];
        int newIndex = index+6;
        Gem * newGem = _gems[newIndex];
        if (newGem.color == gem.color)
        {
            [_tempRun addObject:gem];
            //NSLog(@"match below, color = %d, newColor = %d, index = %d, newIndex = %d", gem.color, newGem.color, index, newIndex);
            [self findMatchesBelowGem:newGem index:newIndex];
        }
    }
}

-(void)findMatchesLeftGem:(Gem*)gem index:(int)index
{
    int x = index % 6;
    if (x == 0) return;
    else
    {
        [_tempRun addObject:gem];
        int newIndex = index-1;
        Gem * newGem = _gems[newIndex];
        if (newGem.color == gem.color)
        {
            [_tempRun addObject:gem];
            //NSLog(@"match left, color = %d, newColor = %d, index = %d, newIndex = %d, x = %d, temp count = %d", gem.color, newGem.color, index, newIndex, x, _tempRun.count);
            [self findMatchesLeftGem:newGem index:newIndex];
        }
    }
}

-(void)findMatchesRightGem:(Gem*)gem index:(int)index
{
    int x = index % 6;
    if (x == 5) return;
    else
    {
        [_tempRun addObject:gem];
        int newIndex = index+1;
        Gem * newGem = _gems[newIndex];
        if (newGem.color == gem.color)
        {
            [_tempRun addObject:gem];
            //NSLog(@"match left, color = %d, newColor = %d, index = %d, newIndex = %d", gem.color, newGem.color, index, newIndex);
            [self findMatchesRightGem:newGem index:newIndex];
        }
    }
}

-(void)addRun:(NSMutableSet*)newRun
{
    [_run addObjectsFromArray:newRun.allObjects];
}

-(void)findRunFromGem:(Gem*)gem index:(int)index
{
    [_tempRun removeAllObjects];
    [self findMatchesAboveGem:gem index:index];
    if (_tempRun.count > 2) [self addRun:_tempRun];
    [_tempRun removeAllObjects];
    [self findMatchesBelowGem:gem index:index];
    if (_tempRun.count > 2) [self addRun:_tempRun];
    [_tempRun removeAllObjects];
    [self findMatchesLeftGem:gem index:index];
    if (_tempRun.count > 2) [self addRun:_tempRun];
    [_tempRun removeAllObjects];
    [self findMatchesRightGem:gem index:index];
    if (_tempRun.count > 2) [self addRun:_tempRun];
}

-(void)clearAndFillBoard
{
    // slide down
    NSMutableSet * used = [NSMutableSet set];
    for (int column = 0; column < 6; column ++)
    {
        for (int row = 0; row < 5; row ++)
        {
            int thisIndex = (row*6)+column;
            Gem * thisGem = _gems[thisIndex];
            //if (![_run containsObject:thisGem]) continue;
            //NSLog(@"testing this %d, %d, %d", thisIndex, row, column);
            for (int newRow = row; newRow < 5; newRow++)
            {
                int newIndex = (newRow*6)+column;
                Gem * newGem = _gems[newIndex];
                if (![_run containsObject:newGem] && ![used containsObject:newGem])
                {
                    //NSLog(@"replace %d with %d", thisIndex, newIndex);
                    [used addObject:newGem];
                    [_gems replaceObjectAtIndex:thisIndex withObject:newGem];
                    [_gems replaceObjectAtIndex:newIndex withObject:thisGem];
                    break;
                }
            }
        }
    }
    // fill spaces
    for (Gem * gem in _run)
    {
        int index = [_gems indexOfObject:gem];
        int x = index % 6;
        Gem * newGem = [self createRandomGem];
        newGem.sprite.position = CGPointMake(27.5+(x*53), 290.5);
        [self addChild:newGem.sprite];
        [_gems replaceObjectAtIndex:index withObject:newGem];
        [self removeChild:gem.sprite];
    }
    [self updateGemPositionsAfterSwap:0.5];
}

-(void)processBatches:(NSMutableArray*)batches
{
    if (batches.count == 0) return;
    NSMutableArray * batch = [batches lastObject];

    for (Gem * gem in batch)
    {
        CCFadeOut * fadeOut = [[CCFadeOut alloc] initWithDuration:0.25];
        CCCallBlock * completion = [[CCCallBlock alloc] initWithBlock:^{
            _howManyToProcess --;
            if (_howManyToProcess == 0)
            {
                [self clearAndFillBoard];
                float delayInSeconds = 0.75;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self turnEnd];
                });
            }
        }];
        CCSequence * sequence = [[CCSequence alloc] initOne:fadeOut two:completion];
        [gem.sprite runAction:sequence];
    }
    [batches removeObject:batch];
    float delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self processBatches:batches];
    });
}

-(void)turnEnd
{
    _allowInput = NO;
    [_run removeAllObjects];
    for (int i = 29; i >= 0; i--)
    {
        [self findRunFromGem:_gems[i] index:i];
    }
    if (_run.count > 0)
    {
        _howManyToProcess = _run.count;
        
        NSMutableArray * batches = [NSMutableArray array];
        for (int i = 1; i < 7; i++)
        {
            NSMutableArray * batch = [NSMutableArray array];
            for (Gem * gem in _run)
            {
                if (gem.color == i)
                {
                    [batch addObject:gem];
                }
            }
            if (batch.count > 0)
                [batches addObject:batch];
        }
        
        //NSLog(@"batches %d", batches.count);
        [self processBatches:batches];
    }
    else
    {
        _allowInput = YES;
    }
}

#pragma mark touch handling

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!_allowInput) return NO;
    
    CGPoint location = [self convertTouchToNodeSpace: touch];

    //NSLog(@"%@", _gems);
    
    for (Gem * container in _gems)
    {
        if (!_dragGem && CGRectContainsPoint(container.sprite.boundingBox, location))
        {
            _dragGem = [[Gem alloc] init];
            _dragGem.color = container.color;
            _dragGem.sprite = [self createGemWithColor:container.color];
            [_dragGem.sprite setPosition:container.sprite.position];
            [self addChild:_dragGem.sprite];
            _realDragGem = container;
            container.sprite.opacity = 128;
            _dragOffset = CGPointMake(location.x-container.sprite.boundingBox.origin.x-26.5, location.y-container.sprite.boundingBox.origin.y-26.5);
            _dragGem.sprite.zOrder = 10;
            return YES;
        }
    }
    return NO;
}

-(void)updateGemPositionsAfterSwap:(float)duration
{
    float startY = 25.5;
    float startX = 27.5;
    
    for (int y = 0; y < 5; y++)
    {
        for (int x = 0; x < 6; x++)
        {
            int idx = x+(y*6);
            Gem * container = _gems[idx];
            if (container.sprite.position.x != startX || container.sprite.position.y != startY)
            {
                CCMoveTo * moveTo = [[CCMoveTo alloc] initWithDuration:duration position:CGPointMake(startX, startY)];
                [container.sprite runAction:moveTo];
            }
            startX += 53;
        }
        startY += 53;
        startX = 27.5;
    }
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!_allowInput) return;
    
    if (_dragGem)
    {
        CGPoint location = [self convertTouchToNodeSpace: touch];
        location.x -= _dragOffset.x;
        location.y -= _dragOffset.y;
        [_dragGem.sprite setPosition:location];
        Gem * swapGem = nil;
        for (Gem * container in _gems)
        {
            if (container != _realDragGem && container.sprite.numberOfRunningActions == 0 && CGRectContainsPoint(container.sprite.boundingBox, location))
            {
                swapGem = container;
                break;
            }
        }
        if (swapGem)
        {
            int idxA = [_gems indexOfObject:swapGem];
            int idxB = [_gems indexOfObject:_realDragGem];
            [_gems replaceObjectAtIndex:idxA withObject:_realDragGem];
            [_gems replaceObjectAtIndex:idxB withObject:swapGem];
            [self updateGemPositionsAfterSwap:0.05];
        }
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self removeChild:_dragGem.sprite];
    _realDragGem.sprite.opacity = 255.0;
    _realDragGem = nil;
    _dragGem = nil;
    _dragOffset = CGPointZero;
    [self turnEnd];
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self ccTouchEnded:touch withEvent:event];
}

@end
