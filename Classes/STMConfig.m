//
//  STMConfig.m
//  Spank The Monkey
//
//  Created by Cleave Pokotea on 25/02/09.
//  Copyright 2009-2011 Tumunu. All rights reserved.
//

#import "STMConfig.h"
#import "cocos2d.h"
#import "STMAppDelegate.h"


#define kFontSize  @"fontSize"
#define kSmallFontSize @"smallFontSize"
#define kTimerFontSize @"timerFontSize"
#define kFontName @"fontName"
#define kFixedFontName @"fixedFontName"
#define kTimerFontName @"timerFontName"

#define kTransitionDuration @"transitionDuration"
#define kScore @"score"
#define kBonus @"bonus"
#define kHitEffect @"hitEffect"
#define kSoundFXEnabledKey @"soundfx"


@implementation STMConfig


- (id) init {
    self = [super init];
    if (self != nil) {
        
        defaults = [[NSUserDefaults standardUserDefaults] retain];
        
        [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInteger: 34], kFontSize,
                                    [NSNumber numberWithInteger: 18], kSmallFontSize,
                                    [NSNumber numberWithInteger: 49], kTimerFontSize,
                                    @"Marker Felt", kFontName,
                                    @"American Typewriter", kFixedFontName,
                                    @"Helvetica", kTimerFontName,
                                    
                                    //[NSNumber numberWithFloat: 0.5f], kTransitionDuration,
                                    [NSNumber numberWithFloat: 1.0f], kTransitionDuration,
                                    [NSNumber numberWithInteger: 1],  kScore,
                                    [NSNumber numberWithInteger: 1],  kBonus,
                                    [NSNumber numberWithBool:    YES], kHitEffect,

                                    nil]];
    }
    [self setScore:0];
    b = YES;
    return self;
}


+(STMConfig *) get {
    
    static STMConfig *instance;
    if(!instance) {
        
        instance = [[STMConfig alloc] init];
    }
    
    return instance;
}


-(float) stmScale {
    
    return 0.4f;
}


#pragma mark Fonts
-(int) fontSize {
    
    return [defaults integerForKey: kFontSize];
}
-(void) setFontSize: (int)fontSize {
    
    [defaults setInteger:fontSize forKey: kFontSize];
}


-(int) smallFontSize {
    
    return [defaults integerForKey: kSmallFontSize];
}
-(void) setSmallFontSize: (int)smallFontSize {
    
    [defaults setInteger:smallFontSize forKey: kSmallFontSize];
}


-(int) timerFontSize {
    
    return [defaults integerForKey: kTimerFontSize];
}
-(void) setTimerFontSize: (int)timerFontSize {
    
    [defaults setInteger:timerFontSize forKey: kTimerFontSize];
}


-(NSString *) fontName {
    
    return [defaults stringForKey: kFontName];
}
-(void) setFontName: (NSString *)fontName {
    
    [defaults setObject:fontName forKey: kFontName];
}


-(NSString *) fixedFontName {
    
    return [defaults stringForKey: kFixedFontName];
}
-(void) setFixedFontName: (NSString *)fixedFontName {
    
    [defaults setObject:fixedFontName forKey: kFixedFontName];
}


-(NSString *) timerFontName {
    
    return [defaults stringForKey: kTimerFontName];
}
-(void) setTimerFontName: (NSString *)timerFontName {
    
    [defaults setObject:timerFontName forKey: kTimerFontName];
}


#pragma mark Other bits & pieces
-(ccTime) transitionDuration {
    
    return [defaults floatForKey: kTransitionDuration];
}
-(void) setTransitionDuration: (ccTime)transitionDuration {
    
    [defaults setFloat:transitionDuration forKey: kTransitionDuration];
}


-(int) score {
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:kScore]) {
        
        NSLog(@"is not yet defined [%s:%d] ",__FUNCTION__,__LINE__);
    }
    
    return [defaults integerForKey: kScore];
}
-(void) setScore: (int)n {


    if(n < 0 || n==0) {
        
            n = 0;   
    } else {
        if(b) {
            n = [self score] + n;
        } else {
            n = n;
        }
    }

    
    [defaults setInteger:n forKey: kScore];
    NSLog(@"%d [%s:%d] ",[self score],__FUNCTION__,__LINE__);
}



-(int) bonus {
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:kBonus]) {
        
        NSLog(@"is not yet defined [%s:%d] ",__FUNCTION__,__LINE__);
    }
    
    return [defaults integerForKey: kBonus];
}
-(void) setBonus: (int)n {
    
    b = NO;
    if(n < 0 || n==0) {
        
        n = 0;   
    }
    
    [defaults setInteger:n forKey: kBonus];
    NSLog(@"%d [%s:%d] ",[self bonus],__FUNCTION__,__LINE__);
}


-(BOOL) hitEffect {
    
    return [defaults boolForKey: kHitEffect];
}
-(void) setHitEffect: (BOOL)nEffects {
    
    [defaults setBool:nEffects forKey: kHitEffect];
}


@end
