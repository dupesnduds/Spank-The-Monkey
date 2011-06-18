//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: HitHead.h
//
//	Last modified: 25/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface HitHead : Sprite {
	Animation *hhAnimation;
	
	int frameCount;
}

@property (nonatomic, retain) Animation *hhAnimation;

-(void) tick: (ccTime) dt;


@end