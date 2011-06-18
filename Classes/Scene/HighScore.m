//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: HighScore.m
//
//	Last modified: 25/02/09
//

#import "HighScore.h"
#import "ScoresLayer.h"
#import "STMConfig.h"


@implementation HighScore

- (id) init {
    self = [super init];
    if (self != nil) {

        [Texture2D saveTexParameters];
        [Texture2D setAliasTexParameters];
        AtlasSpriteManager *mgrTwo = [AtlasSpriteManager spriteManagerWithFile:@"s_bkgnd_1.png" capacity:4];
        [self addChild:mgrTwo z:0 tag:kTagSpriteManagerTwo];
        [Texture2D restoreTexParameters];
        
        AtlasSprite *bg = [AtlasSprite spriteWithRect:CGRectMake(0, 320, 480, 320) spriteManager: mgrTwo];
        bg.position = ccp(240, 160);
        [mgrTwo addChild:bg];

        ScoresLayer * layer = [ScoresLayer node];
		[self addChild:layer];        
    }
    return self;
}


@end
