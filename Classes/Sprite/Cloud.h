//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: STM007
//	File: Cloud.h
//
//	Last modified: 25/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface Cloud : Sprite {
    
    NSString * name;
    
}

@property (readwrite, retain) NSString * name;

-(cpVect) contentVect;
-(void) scaleBy:(float)n;

@end