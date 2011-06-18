//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: Stage.m
//
//	Last modified: 25/02/09
//

#import "StageLayer.h"
#import "Sun.h"
#import "CloudLayer.h"


@implementation StageLayer


-(void) dealloc {
    
    if(sun) {
        
        [sun release];
        sun = nil;
    }
    
    if(clouds) {
        
        [clouds release];
        clouds = nil;
    }
    
    [super dealloc];
}


- (id) init {
    self = [super init];
    if (self != nil) {
        
        CGSize s = [[Director sharedDirector] winSize];
        sun = [[Sun alloc] init];
        [self addChild:sun z:10];
        [sun setPosition:ccp(s.width-55, s.height-60)];
        
        CloudLayer *cloud = [[CloudLayer alloc] init];
        [self addChild:cloud z:99];
        [cloud release];
    }
    return self;
}


@end