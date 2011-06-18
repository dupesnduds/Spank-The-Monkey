//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: GameLayer.m
//
//	Last modified: 25/02/09
//


#import "GameLayer.h"
#import "STMConfig.h"
#import "STMAppDelegate.h"
#import "Sun.h"
#import "MonkeyLayer.h"
#import "Timer.h"
#import "HUDLayer.h"


#define kAccelerationMaximum		2.0
#define kAccelerationThreshold		2.2
#define kAccelerationMedium         1.6
#define kAccelerationMinimum		1.2


@implementation GameLayer


@synthesize running, paused;
@synthesize timer;
@synthesize comments;
@synthesize shouldUpdate, shouldAction;
@synthesize ts, te;


-(void) dealloc 
{
    if(monkey) 
    {
        [monkey release];
        monkey = nil;
    }
    
    if(timer) 
    {
        [timer release];
        timer = nil;
    }
    
    if(hud) 
    {
        [hud release];
        hud = nil;
    }
    
    [msgLabel release];
    msgLabel = nil;
    
    ///*
    if(comments) {
        [comments release];
        comments = nil;
    }
    //*/
    
    [super dealloc];
}


double GetCurrentTime(void) 
{
    struct timeval time;
    gettimeofday(&time, nil);
    return (double)time.tv_sec + (0.000001 * (double)time.tv_usec);
}


- (id) init 
{
    self = [super init];
    if (self != nil) 
    {
        isTouchEnabled = YES;
        isAccelerometerEnabled = YES;
        CGSize s = [[Director sharedDirector] winSize];
        
        running = true;
        paused = false;
        
        clockLabel = [Label labelWithString:@"00:00" dimensions:CGSizeMake(s.width, 50) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:49];
        [clockLabel setPosition: ccp(80, s.height-40)];
        [clockLabel setRGB:0:0:0];
        [self addChild:clockLabel z:11];
        
        monkey = [[MonkeyLayer alloc] init];
        [self addChild:monkey z:100];
        
        hud = [[HUDLayer alloc] init];
        [self addChild:hud z:200];
        
        // Custom initialization
		timer = [[STMTimer alloc] init];
		timer.delegate = self;
        [self startTimer];
        
        [self message:@"Spank the monkey!"];
        
        comments = [[NSMutableArray alloc] initWithObjects:
                        @"Did I do that?",
                        @"Who's your daddy?",
                        @"Settle down tiger!",
                        @"May I have another?",
                        @"That tickles!",
                        @"Please be gentle.",
                        @"Oh my gosh!",
                        @"Hmmmm, I like!",
                        @"That's it!",
                        @"Spank the monkey!",
                        @"Yeoooooooooooowch",
                        nil];
        
        [self schedule: @selector(step:) interval: 1.0 / 60.0];
        shouldUpdate = 0;
        shouldAction = 0;
        ts = GetCurrentTime();

        [STMAppDelegate playEffect:kTransScore];
    }
    return self;
}



- (void)timerDidUpdate:(STMTimer *)atimer 
{
    NSString *s = [NSString stringWithFormat:@"%@:%@", [timer stringMinutes], [timer stringSeconds]];
    [clockLabel setString:s];
}


-(void) pause 
{
    if(!running) 
    {
        // Only allow toggling pause state while game is running.
        return;
    }

    // TODO: Change to gfx
    if(!paused) 
    {
        [self message:@"Paused"];
    }
    
    paused = true;
    [self stopTimer];
    [[UIApplication sharedApplication] setStatusBarHidden:false animated:true];
}


-(void) unpause 
{
    if(!running) 
    {
        // Only allow toggling pause state while game is running.
        return;
    }
    
    // TODO: Change to gfx
    if(paused) 
    {
        [self message:@"Unpaused!"];
    }
    
    paused = false;
    [self startTimer];
    [[UIApplication sharedApplication] setStatusBarHidden:true animated:true];
}


-(void) stopGame 
{
    if(!running) 
    {
        return;
    }
    
    [self stopTimer];
    paused = false;
    [self unpause];
}


-(void) stopped 
{
    paused = true;
    [self pause];
    
    running = false;
}


-(void) message: (NSString *)msg 
{
    NSLog(@"%@  [%s:%d] ",msg,__FUNCTION__,__LINE__);
    
    if(!msgLabel) 
    {
        NSLog(@"msgLabel == false  [%s:%d] ",__FUNCTION__,__LINE__);
        msgLabel = [[Label alloc] initWithString:@"" dimensions:CGSizeMake(1000, 20 + 5)
                                       alignment:UITextAlignmentLeft
                                        fontName:@"Marker Felt"
                                        fontSize: 24];
        [self addChild:msgLabel z:101];
        CGSize s = [[Director sharedDirector] winSize];
        
        [msgLabel setPosition: ccp(100, s.height/2)];
    }
    
    [self resetMessage:nil];
    [msgLabel setVisible:true];
    [msgLabel setString:msg];
    [msgLabel runAction:[Sequence actions:
                  [MoveBy actionWithDuration:1 position:ccp(0, 59)],
                  [FadeOut actionWithDuration:2],
                  [CallFunc actionWithTarget:self selector:@selector(resetMessage:)],
                  nil]];
}


-(void) resetMessage: (id) sender 
{
    [msgLabel stopAllActions];
    
    CGSize s = [[Director sharedDirector] winSize];

    [msgLabel setPosition:ccp([msgLabel contentSize].width / 2 + 20, s.height - s.height)];
    [msgLabel setOpacity:0xff];
    [msgLabel setVisible:false];
}


- (void)startTimer 
{
	[timer start];
}

- (void)stopTimer 
{
	[timer stop];
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration 
{
    if(running)
    {
        float startTime = GetCurrentTime();
        int randomComment = arc4random() % [comments count];
        
        // The usual threshold. More than this equates to the iPhone being dropped out of a window and smashing on the ground ;)
        if (fabsf(acceleration.x) > kAccelerationThreshold || fabsf(acceleration.y) > kAccelerationThreshold || fabsf(acceleration.z) > kAccelerationThreshold) 
        {
            [self slap];

            float endTime = GetCurrentTime();
            float velocity = (fabsf(acceleration.x + acceleration.y + acceleration.z) * (startTime / endTime)) * 100;
            int s = (int)velocity;
 
            [self adjustScore: s d:20];
        
            if(shouldAction == 8) 
            {
                shouldAction = 0;
                [self message:[comments objectAtIndex:randomComment]];
                [STMAppDelegate playEffect:kEffectChatter];
            }

        } else if (fabsf(acceleration.x) > kAccelerationMaximum || fabsf(acceleration.y) > kAccelerationMaximum || fabsf(acceleration.z) > kAccelerationMaximum) {
  
            float endTime = GetCurrentTime();
            float velocity = (fabsf(acceleration.x + acceleration.y + acceleration.z) * (startTime / endTime)) * 100;
            int s = (int)velocity;

            [self adjustScore: s d:15];
        
            [self slap];
            if(shouldAction == 8) 
            {
                shouldAction = 0;
                [self message:[comments objectAtIndex:randomComment]];
                [STMAppDelegate playEffect:kEffectGasp];
            }
        
        } else if (fabsf(acceleration.x) > kAccelerationMedium || fabsf(acceleration.y) > kAccelerationMedium || fabsf(acceleration.z) > kAccelerationMedium) {
        
            float endTime = GetCurrentTime();
            float velocity = (fabsf(acceleration.x + acceleration.y + acceleration.z) * (startTime / endTime)) * 100;
            int s = (int)velocity;
        
            [self adjustScore: s d:10];
        
            [self slap];
            if(shouldAction == 8) {
            
                shouldAction = 0;
                [self message:[comments objectAtIndex:randomComment]];
                [STMAppDelegate playEffect:kEffectGiggle];
            }
        
        } else if (fabsf(acceleration.x) > kAccelerationMinimum || fabsf(acceleration.y) > kAccelerationMinimum || fabsf(acceleration.z) > kAccelerationMinimum) {
        
            float endTime = GetCurrentTime();
            float velocity = (fabsf(acceleration.x + acceleration.y + acceleration.z) * (startTime / endTime)) * 100;
            int s = (int)velocity;
        
            [self adjustScore: s d:5];
        
            [self slap];
            if(shouldAction == 8) 
            {
                shouldAction = 0;
                [self message:[comments objectAtIndex:randomComment]];
                [STMAppDelegate playEffect:kEffectFart];
            }
        
        }
    }
}

-(void) adjustScore:(int)velocity d:(int)d 
{
    NSLog(@"\r\nAdjust score %d",[[STMConfig get] score]);
    
    if ( [[STMConfig get] score] == 0 ) 
    {
        [[STMConfig get] setScore: velocity * d / 100];
        
    } else {
        
        [[STMConfig get] setScore: ( [[STMConfig get] score] / 10 ) + velocity * ( d / 1000 )];
    }
}


-(void) slap 
{
    if([[STMConfig get] hitEffect]) 
    {
        [STMAppDelegate playEffect:kEffectPunch];

    } else {
        
        [STMAppDelegate playEffect:kEffectSlap];
    }
        
    [monkey monkeyScale];
    shouldAction++;
}


-(void) step: (ccTime) delta 
{
    if ([[STMConfig get] score] > 500 && shouldUpdate==0) 
    {
        shouldUpdate++;
        [monkey monkeyJump];
        [STMAppDelegate playEffect:kEffectDing];
        [hud changeStar:kStarOne];
    } else if ([[STMConfig get] score] > 4500 && shouldUpdate==1) {
            
        shouldUpdate++;
        [monkey monkeyMove];
        [STMAppDelegate playEffect:kEffectDing];
        [hud changeStar:kStarTwo];
    } else if ([[STMConfig get] score] > 23500 && shouldUpdate==2) {
            
        shouldUpdate++;
        [monkey setCurrentState:NO];
        [monkey monkeyJump];
        [STMAppDelegate playEffect:kEffectDing];
        [hud changeStar:kStarThree];
    } else if ([[STMConfig get] score] > 90000 && shouldUpdate==3) {
           
        running = false;
        shouldUpdate++;
        [monkey monkeyJump];
        [STMAppDelegate playEffect:kEffectDing];
        [hud changeStar:kStarFour];
        
        // Game over
        [self stopAllActions];
        te = GetCurrentTime();
        
        // add time bonus
        float timeBonus = te - ts;
        NSLog(@"\r\n Time start: %2.2f\r\n Time End: %2.2f\r\n Time Bonus: %2.2f",ts,te,timeBonus);
        NSLog(@"%d",[[STMConfig get] score]);
        
        [[STMConfig get] setBonus: (int)timeBonus];
        [STMAppDelegate playBackgroundMusic];
        [[Director sharedDirector] replaceScene:[TurnOffTilesTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneEnd]]];
    }
}


@end