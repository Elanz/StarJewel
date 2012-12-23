//
//  DesktopLayer.h
//  StarJewel
//
//  Created by Eric Lanz on 11/23/12.
//  Copyright 2012 200 Monkeys. All rights reserved.
//

#import "cocos2d.h"

@interface DesktopLayer : CCLayer
{
    CCScene * _gameScene;
}

+(CCScene *) scene;

@end
