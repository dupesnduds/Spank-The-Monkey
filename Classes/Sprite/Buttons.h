//
//  Buttons.h
//  Spanking The Monkey
//
//  Created by Cleave Pokotea on 9/03/09.
//  Copyright 2009-2011 Tumunu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"


@interface Buttons : NSObject
{
    BOOL currentState;
    Sprite * mm_normal;
    Sprite * mm_green;
}


@property (readwrite, assign) BOOL currentState;
@property (readwrite, retain) Sprite * mm_normal;
@property (readwrite, retain) Sprite * mm_green;

-(Sprite *)currentSprite;

-(BOOL)currentState;
-(void)setCurrentState:(BOOL)b;


@end
