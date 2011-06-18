//
//	Created by Cleave Pokotea on 2/03/09
//
//	Project: STM008
//	File: GameOver.m
//
//	Last modified: 2/03/09
//
#include <sys/time.h>
#import "cocoslive.h"

#import "EndLayer.h"
#import "STMAppDelegate.h"
#import "STMConfig.h"

//#import "CocosNodeExtras.h"


#define kMainMenu 0x00ff44
#define kSave 0x00ff45
#define kFB 0x00ff46


// This application will not work until you enter your Facebook application's API key here:

//static NSString* kApiKey = @"59c1ad3896fdb16ea391ee575ad42720";

// Enter either your API secret or a callback URL (as described in documentation):
//static NSString* kApiSecret = @"cf35541b9f675f73801fa027562518fb"; 



@implementation EndLayer


@synthesize currentState;


-(void) dealloc {
    
    if(loadingLabel) {
        
        [loadingLabel release];
        loadingLabel = nil;
    }
    
    if(monkey) {
        
        [monkey release];
        monkey = nil;
    }
    
    if(finalRank) {
        
        [finalRank release];
    }
    
    [super dealloc];
}


- (id) init {
    
    self = [super init];
    if (self != nil) {
        
        isTouchEnabled = YES;
        [self setCurrentState:YES];

        monkey = [[MonkeyLayer alloc] init];
        [self addChild:monkey z:100];
        
        [mm setCurrentState:NO];
        mm = [[Buttons alloc] init];
        [self addChild:[mm currentSprite] z:12 tag:kMainMenu]; 
        
        so = [Sprite spriteWithFile:@"b_save_score.png"];      
        [self addChild:so z:11 tag:kSave];
        
        int newScore = ([[STMConfig get] score] / [[STMConfig get] bonus]) * 10;

        [[STMConfig get] setScore:newScore];
        NSLog(@"Final score: %d",newScore);
        
        if(!newScore) {
            
            newScore = 12;
        }
        
        rankLabel = [Label labelWithString:@" " fontName:@"Marker Felt" fontSize:24]; 
        [rankLabel setRGB:75:52:41];
        [self addChild:rankLabel];
        
        endLabel = [Label labelWithString:@" " fontName:@"Marker Felt" fontSize:18]; 
        [endLabel setRGB:75:52:41];
        [self addChild:endLabel];
        
        if(newScore < 5000) {

            finalRank = [[NSString alloc] initWithString:@"MOUSE!"];
            [endLabel setString:@"You're kidding?"];
        } else if (newScore < 15000 && newScore > 5000) {
            
            finalRank = [[NSString alloc] initWithString:@"NOVICE!"];
            [endLabel setString:@"Umm, try again ..."];
        } else if (newScore < 30000 && newScore > 15000) {
            
            finalRank = [[NSString alloc] initWithString:@"SLAPPER!"];
            [endLabel setString:@"Feeling better?"];
        } else if (newScore < 70000 && newScore > 30000) {
            
            finalRank = [[NSString alloc] initWithString:@"CHAMPION!"];
            [endLabel setString:@"The greatest!"];
        } else if (newScore < 100000 && newScore > 70000) {
            
            finalRank = [[NSString alloc] initWithString:@"APE!"];
            [endLabel setString:@"Thank you sir!"];
        } else if (newScore >= 100000) {
            
            finalRank = [[NSString alloc] initWithString:@"HERO!"];
            [endLabel setString:@"Praise be!"];
        }      
        
        [rankLabel setString:finalRank];
        finalScore = newScore;
        
        scoreText = [[NSString alloc] init];
        scoreText = [NSString stringWithFormat:@"%d", newScore];
        
        scoreLabel = [Label labelWithString:scoreText fontName:@"Helvetica" fontSize:38]; 
        [scoreLabel setRGB:255:0:32];
        [self addChild:scoreLabel];
        
        [self positionDefaults];
        [monkey monkeyJump];
        [self message:@"Well done"];
    }
    return self;
}


-(void) positionDefaults {
    
    [[mm currentSprite] setPosition: ccp([[mm currentSprite] contentSize].width/2+14, 20)];
    [monkey setPosition:ccp(-135,0)];
    
    [so setPosition: ccp(372, 116)];
    [fb setPosition: ccp(372, 80)];
    
    rankLabel.position = ccp([scoreText length]/2+368,215);
    scoreLabel.position = ccp([scoreText length]/2+368,182);
    endLabel.position = ccp([scoreText length]/2+368,145);}


-(void) onEnter {
    
    if(!spinner) {
        
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [spinner setCenter:CGPointMake(160, 240)]; // I do this because I'm in landscape mode
        [[[STMAppDelegate get] window] addSubview:spinner];
    }
    
    [super onEnter];
}


-(BOOL)currentState {
    
    return currentState;
}
-(void) setCurrentState:(BOOL)b {
    
	currentState = b;
}


-(void) goMainMenu {
    
    if(spinner) {
        
        [spinner removeFromSuperview];
        [spinner release];
    }
    
    [STMConfig get]->b = YES;
    [[STMConfig get] setScore:0];
    
    [[Director sharedDirector] replaceScene:[SplitColsTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneMenu]]];
}


-(void) preSend {
    
    [self setCurrentState:NO];    

    UIAlertView* dialog = [[[UIAlertView alloc] init] retain]; 
    [dialog setDelegate:self]; 
    [dialog setTitle:@"Enter your name"]; 
    [dialog setMessage:@" "]; 
    [dialog addButtonWithTitle:@"Cancel"]; 
    [dialog addButtonWithTitle:@"OK"]; 
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 
                                                              245.0, 25.0)]; 
    [nameField setBackgroundColor:[UIColor whiteColor]]; 
    nameField.returnKeyType = UIReturnKeyDone;
    [dialog addSubview:nameField]; 
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 
                                                                90.0); 
    [dialog setTransform: moveUp]; 
    [dialog show]; 
    [dialog release]; 
    [nameField release]; 
}


-(void) message: (NSString *)msg {
    
    NSLog(@"%@  [%s:%d] ",msg,__FUNCTION__,__LINE__);
    
    if(!loadingLabel) {
        
        NSLog(@"msgLabel == false  [%s:%d] ",__FUNCTION__,__LINE__);
        loadingLabel = [[Label alloc] initWithString:@"" dimensions:CGSizeMake(1000, 20 + 5)
                                           alignment:UITextAlignmentLeft
                                            fontName:@"Marker Felt"
                                            fontSize: 24];
        [self addChild:loadingLabel z:101];
        CGSize s = [[Director sharedDirector] winSize];
        
        [loadingLabel setPosition: ccp(100, s.height/2)];
    }
    
    [self resetMessage:nil];
    [loadingLabel setVisible:true];
    [loadingLabel setString:msg];
    [loadingLabel runAction:[Sequence actions:
                      [MoveBy actionWithDuration:1 position:ccp(0, 15)],
                      [FadeOut actionWithDuration:1],
                      [CallFunc actionWithTarget:self selector:@selector(resetMessage:)],
                      nil]];
}


-(void) resetMessage: (id) sender {
    
    [loadingLabel stopAllActions];   
    [loadingLabel setPosition:ccp([loadingLabel contentSize].width / 2 + [[mm currentSprite] contentSize].width+25, 5)];
    [loadingLabel setOpacity:0xff];
    [loadingLabel setVisible:false];
}



#pragma mark -
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)view clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) { // OK pushed
        
        [spinner startAnimating];
        [STMConfig get]->b = YES;
        [self setCurrentState:NO];    
        
        if(![nameField text]) {
            
            [self postScore:@"John Doe" ];
        } else {
            
            [self postScore:[nameField text] ];
        }
        
    } else {
        
        // Cancel pushed
        [self setCurrentState:YES];   
    }
}


#pragma mark -
-(void) postScore:(NSString *) name {
    
	NSLog(@"Posting Score");
    [self message:@"Sending your score to our server"];
    
	// Create que "post" object for the game "DemoGame"
	// The gameKey is the secret key that is generated when you create you game in cocos live.
	// This secret key is used to prevent spoofing the high scores
	ScoreServerPost *server = [[ScoreServerPost alloc] initWithGameName:@"STM" gameKey:@"1c1cc5b4018d3b3cfacb4975563ff35f" delegate:self];
    
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
	
	[dict setObject: [NSNumber numberWithInt: [[STMConfig get] score ]] forKey:@"cc_score"]; // set score
	[dict setObject:name forKey:@"usr_playername"]; // set playername
	[dict setObject:@"shake" forKey:@"cc_category"];
	NSLog(@"Sending data: %@", dict);
    
	[server sendScore:dict];
	// Release. It won't be freed from memory until the connection fails or suceeds
	[server release];
}


#pragma mark -
#pragma mark ScorePost Delegate
-(void) scorePostOk: (id) sender {
    
	NSLog(@"score post OK");
    [self message:@"Your score was added online"];
    [self setCurrentState:YES];    
    [spinner stopAnimating];
    so.visible = NO;
    [[STMConfig get] setScore:0];
    
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent OK" message:@"Your score was added online" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];	
	alert.tag = 0;
	[alert show];
	[alert release];	
    */
}

-(void) scorePostFail: (id) sender {
    
    [self setCurrentState:YES];    
    [spinner stopAnimating];
	NSString *msg = nil;
	tPostStatus status = [sender postStatus];
	if( status == kPostStatusPostFailed ) {
        
		msg = @"Cross your fingers and retry sending";
	} else if( status == kPostStatusConnectionFailed ) {
        
		msg = @"You need internet access to submit score";
    }
	
	NSLog(@"%@", msg);
    [self message:msg];
    
    /*
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Score Post Failed" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];	
	alert.tag = 0;
	[alert show];
	[alert release];
    */
}


- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    for(UITouch *touch in touches) { 
        
        CGPoint location = [touch locationInView: [touch view]];   
        location = [[Director sharedDirector] convertCoordinate: location];
        
        for( Sprite *item in children ) { 
            
            if (item.tag != 0xFFFFFFFF) {
                
                if (CGRectContainsPoint([self rect:item], location)) { 
                    
                    if(item.tag == kMainMenu) {
                        
                        NSLog(@"main menu touched");

                        if(currentState) {
                            [STMAppDelegate playEffect:kEffectButton];
                            [self goMainMenu];
                            return kEventHandled;
                        }
                    }
                    
                    if(item.tag == kSave) {
                        
                        NSLog(@"main menu touched");
                        
                        if(currentState) {
                            [STMAppDelegate playEffect:kEffectButton];
                            [self preSend];
                            return kEventHandled;
                        }
                    }
                }
            } 
        }
    }
    
    return kEventIgnored;
}


-(CGRect) rect:(Sprite *) item { 
    
    CGSize s = [item contentSize]; 
    
    CGRect r = CGRectMake( item.position.x - s.width/2, 
                          item.position.y-s.height/2, 
                          s.width, s.height); 
    
    //cpVect offset = [self absolutePosition]; 
    CGPoint offset = [self convertToWorldSpace:CGPointZero]; 
    
    r.origin.x += offset.x; 
    r.origin.y += offset.y; 
    
    return r; 
}


@end