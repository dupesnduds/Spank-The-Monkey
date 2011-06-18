//
//	Created by Cleave Pokotea on 9/03/09
//
//	Project: STM009
//	File: InfoScene.m
//
//	Last modified: 9/03/09
//

#import "InfoScene.h"
#import "InfoLayer.h"
#import "STMConfig.h"


@implementation InfoScene


- (id) init 
{
    self = [super init];
    
    if (self != nil) {
        
        //[Texture2D saveTexParameters];
        //[Texture2D setAliasTexParameters];
        AtlasSpriteManager *mgrTwo = [AtlasSpriteManager spriteManagerWithFile:@"s_bkgnd_1.png" capacity:4];
        [self addChild:mgrTwo z:0 tag:kTagSpriteManagerTwo];
        //[Texture2D restoreTexParameters];
        
        AtlasSprite *bg = [AtlasSprite spriteWithRect:CGRectMake(0, 320, 480, 320) spriteManager: mgrTwo];
        bg.position = ccp(240, 160);
        [mgrTwo addChild:bg];
        
        InfoLayer *layer = [InfoLayer node];
		[self addChild:layer];
    }
    return self;
}

@end

