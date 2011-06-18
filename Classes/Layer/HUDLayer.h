//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: HUDLayer.h
//
//	Last modified: 25/02/09
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "HealthLayer.h"
#import "SoundFx.h"
#import "Thing.h"
#import "Buttons.h"


@class Menu;


@interface HUDLayer : Layer {

    HealthLayer * health;
    Sprite * hudMenu;
    
    MenuItemImage * info;
    MenuItemImage * scores;
    
    Buttons * mm;
    SoundFx * fx;
    Thing * thing;
}


-(void) positionDefaults;
-(void) goMainMenu;

-(void) changeStar:(int)n;
-(CGRect) rect:(Sprite *) item;

+(HUDLayer *) get;


@end