//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: HealthLayer.h
//
//	Last modified: 25/02/09
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Star.h"


@interface HealthLayer : Layer 
{
    Star * star1;
    Star * star2;
    Star * star3;
    Star * star4;
}

-(void) positionDefaults;
-(void)changeStar:(int)n;
-(void)morph:(Sprite *)s;


@end