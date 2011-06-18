//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: GameLayer.h
//
//	Last modified: 25/02/09
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Timer.h"
#import "MonkeyLayer.h"
#import "HUDLayer.h"


@interface GameLayer : Layer <TimerDelgate, UIAlertViewDelegate> 
{
    BOOL paused;
    BOOL running;
    
    // calculate time bonus
    double ts;
    double te;
    
    Label * msgLabel;
    MonkeyLayer * monkey;
    HUDLayer *hud;
    
    STMTimer *timer;
    Label * clockLabel;
    
    NSMutableArray * comments;
    int shouldUpdate;
    int shouldAction;

}

@property (readonly) BOOL running;
@property (readonly) BOOL paused;
@property (nonatomic, retain) STMTimer *timer;
@property (nonatomic, retain) NSMutableArray * comments;
@property (readwrite) int shouldUpdate;
@property (readwrite) int shouldAction;
@property (readwrite) double ts;
@property (readwrite) double te;


-(void) pause;
-(void) unpause;

-(void) stopGame;
-(void) stopped;

-(void) message: (NSString *)msg;
-(void) resetMessage: (id) sender;

-(void) startTimer;
-(void) stopTimer;

-(void) adjustScore:(int)velocity d:(int)d;
-(void) slap;

-(void) step: (ccTime) dt;


@end