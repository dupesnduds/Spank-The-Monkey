//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Game.m
//
//	Last modified: 25/02/09
//

#import "GameScene.h"
#import "GameLayer.h"
#import "StageLayer.h"


@implementation GameScene


- (void)dealloc {
    
    [super dealloc];
}


- (id) init {
    
    self = [super init];
    if (self != nil) {
        //*
        Sprite *bg = [Sprite spriteWithFile:@"l_game.png"];
        bg.position = ccp(240, 160);
        [self addChild:bg z:0];
        //*/
        StageLayer *slayer = [StageLayer node];
		[self addChild:slayer z:1];
        
        GameLayer *glayer = [GameLayer node];
		[self addChild:glayer z:2];
    }
    return self;
}


@end
