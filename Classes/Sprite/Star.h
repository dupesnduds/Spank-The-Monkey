//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Star.h
//
//	Last modified: 25/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


@interface Star : NSObject {
    
    NSString * name;
    BOOL currentState;
    Sprite * empty;
    Sprite * full;
}

@property (readwrite, retain) NSString * name;
@property (readwrite, assign) BOOL currentState;
@property (readwrite, retain) Sprite * empty;
@property (readwrite, retain) Sprite * full;

-(Sprite *)currentSprite;

-(BOOL)currentState;
-(void)setCurrentState:(BOOL)b;

@end