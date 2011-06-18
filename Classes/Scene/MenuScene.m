//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: MainMenu.m
//
//	Last modified: 25/02/09
//


#import "MenuScene.h"
#import "MenuLayer.h"
#import "STMConfig.h"


@implementation MenuScene


- (void)dealloc
{
    [super dealloc];
}


- (id) init
{
    self = [super init];
    if (self != nil) 
    {
        [Texture2D saveTexParameters];
        [Texture2D setAliasTexParameters];
        AtlasSpriteManager *mgrTwo = [AtlasSpriteManager spriteManagerWithFile:@"s_bkgnd_1.png" capacity:4];
        [self addChild:mgrTwo z:0 tag:kTagSpriteManagerTwo];
        [Texture2D restoreTexParameters];
        
        AtlasSprite *bg = [AtlasSprite spriteWithRect:CGRectMake(0, 0, 480, 320) spriteManager: mgrTwo];
        bg.position = ccp(240, 160);
        [mgrTwo addChild:bg];

        MenuLayer *layer = [MenuLayer node];
		[self addChild:layer z:1];
        
    }
    return self;
}


@end