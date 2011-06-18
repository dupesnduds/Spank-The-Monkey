//
//	Created by Cleave Pokotea on 2/03/09
//
//	Project: Spank The Monkey
//	File: EndScene.m
//
//	Last modified: 2/03/09
//


#import "EndScene.h"
#import "EndLayer.h"


@implementation EndScene


- (id) init
{
    self = [super init];
    if (self != nil) 
    {
        Sprite *bg = [Sprite spriteWithFile:@"l_end.png"];
        bg.position = ccp(240, 160);
        [self addChild:bg z:0];

        EndLayer *layer = [EndLayer node];
		[self addChild:layer];
    }
    return self;
}


@end

