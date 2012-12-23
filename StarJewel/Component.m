//
//  Component.m
//  StarJewel
//
//  Created by Eric Lanz on 11/25/12.
//  Copyright (c) 2012 200 Monkeys. All rights reserved.
//

#import "Component.h"

@implementation Component

- (id) initWithType:(int)type hp:(int)hp attack:(int)attack color1:(int)color1 color2:(int)color2 filename:(NSString *)filename
{
    if ((self = [super init]))
    {
        self.hp = hp;
        self.attack = attack;
        self.type = type;
        self.color1 = color1;
        self.color2 = color2;
        self.sprite = [[CCSprite alloc] initWithFile:filename];
    }
    
    return self;
}

@end
