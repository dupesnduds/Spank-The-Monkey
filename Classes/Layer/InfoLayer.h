//
//	Created by Cleave Pokotea on 9/03/09
//
//	Project: Spank The Monkey
//	File: InfoLayer.h
//
//	Last modified: 9/03/09
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Buttons.h"


@interface InfoLayer : Layer 
{
    Buttons * mm;
}

-(void) positionDefaults;
-(void) goMainMenu;
-(CGRect) rect:(Sprite *) item;


@end