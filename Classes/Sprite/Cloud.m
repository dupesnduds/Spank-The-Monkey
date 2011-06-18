//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: STM007
//	File: Cloud.m
//
//	Last modified: 25/02/09
//

#import "Cloud.h"


@implementation Cloud


@synthesize name;


-(void) dealloc {
    
    if(name) {
        [name release];
        name = nil;
    }
    
    [super dealloc];
}


-(id) init {
    
    if(!(self = [super initWithFile:@"cloud.png"])) {
        
        return self;
    }
    
    
    return self;
}


-(cpVect) contentVect {
    
    return cpv([super contentSize].width * [self scale], [super contentSize].height * [self scale]);
}


-(void) scaleBy:(float)n {
    
    [self setScale:n];    
}


@end
