//
//  Player.h
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Component;

@interface Player : NSObject

@property (nonatomic, retain) Component * hull;
@property (nonatomic, retain) Component * slot1;
@property (nonatomic, retain) Component * slot2;
@property (nonatomic, retain) Component * slot3;
@property (nonatomic, retain) Component * slot4;

+ (Player*) sharedPlayer;

- (int) computeHp;

@end
