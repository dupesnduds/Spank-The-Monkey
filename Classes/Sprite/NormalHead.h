//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: NormalHead.h
//
//	Last modified: 25/02/09
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface NormalHead : Sprite 
{
	Animation *nhAnimation;
	
	int frameCount;
}

@property (nonatomic, retain) Animation *nhAnimation;


@end