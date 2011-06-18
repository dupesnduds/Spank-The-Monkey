//
//	Created by Cleave Pokotea on 27/02/09
//
//	Project: Spank The Monkey
//	File: Object.h
//
//	Last modified: 27/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

/*
// NOTE: Add enum here if using enum for touch detection!
enum { 
    kObjects = 0xaabbcc02, 
    kObjectPaddle = kObjects | 0x01, 
    kObjectGlove = kObjects | 0x02, 
    kObjectMax, 
}; 
*/


@interface Thing : NSObject {
    
    NSString * name;
    BOOL currentState;
    Sprite * paddle;
    Sprite * glove;
}

@property (readwrite, retain) NSString * name;
@property (readwrite, assign) BOOL currentState;
@property (readwrite, retain) Sprite * paddle;
@property (readwrite, retain) Sprite * glove;

-(Sprite *)currentSprite;

-(BOOL)currentState;
-(void)setCurrentState:(BOOL)b;


@end