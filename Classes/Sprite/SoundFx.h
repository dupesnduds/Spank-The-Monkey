//
//	Created by Cleave Pokotea on 26/02/09
//
//	Project: Spank the Monkey
//	File: Speaker.h
//
//	Last modified: 26/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


@interface SoundFx : NSObject {
    
    NSString * name;
    BOOL currentState;
    Sprite * mute;
    Sprite * on;
}

@property (readwrite, retain) NSString * name;
@property (readwrite, assign) BOOL currentState;
@property (readwrite, retain) Sprite * mute;
@property (readwrite, retain) Sprite * on;

-(Sprite *)currentSprite;

-(BOOL)currentState;
-(void)setCurrentState:(BOOL)b;


@end