//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: RageLite
//	File: MonkeyLayer.h
//
//	Last modified: 25/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Body.h"
#import "NormalHead.h"
#import "HitHead.h"


@interface MonkeyLayer : Layer {
    
    CGSize s;
    BOOL currentState;
    Body * body;
    NormalHead * nh;
    HitHead * hh;
}

@property (readwrite, assign) BOOL currentState;
@property (readonly) Body * body;
@property (readonly) NormalHead *nh;
@property (readonly) HitHead *hh;


-(void) positionDefaults;
-(Sprite *) currentHead;
-(void) monkeyJump;
-(void) monkeyScale;
-(void) monkeyMove;
-(void) monkeyWin;


@end