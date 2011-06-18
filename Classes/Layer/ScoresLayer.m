//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: HighScore.m
//
//	Last modified: 25/02/09
//
#import "cocoslive.h"

#import "ScoresLayer.h"
#import "STMAppDelegate.h"
#import "STMConfig.h"


#define kDownload 0x00ff22
#define kReload 0x00ff23
#define kMainMenuG 0x00ff24


@implementation ScoresLayer


-(void) dealloc {    
    
    if(loadingLabel) {
        
        [loadingLabel release];
        loadingLabel = nil;
    }

    [super dealloc];
}


- (id) init {
    self = [super init];
    if (self != nil) {
        
        isTouchEnabled = YES;
        
        //rf = [Sprite spriteWithFile:@"b_refresh_scores.png"];      
        //[self addChild:rf z:10 tag:kReload];
        //[rf setPosition: cpv(395, 290)];
        
        
        ds = [Sprite spriteWithFile:@"b_download_scores.png"];      
        [self addChild:ds z:11 tag:kDownload];
        
        [mm setCurrentState:NO];
        mm = [[Buttons alloc] init];
        [self addChild:[mm currentSprite] z:12 tag:kMainMenuG];
        
        [self positionDefaults];
        [STMAppDelegate playEffect:kTransInfo];
    }
    return self;
}


-(void) positionDefaults {
    
    [ds setPosition: ccp(392, 302)];
    //[ds setPosition: cpv([ds contentSize].width/2+14, 302)];
    [[mm currentSprite] setPosition: ccp([[mm currentSprite] contentSize].width/2+14, 20)];
}


-(void) onEnter {
    /*
    // High Scores
    Label * hsl = [Label labelWithString:@"High Scores" fontName:@"Marker Felt" fontSize:24]; 
    [hsl setRGB:0:0:0];
    hsl.position = cpv(120,290);
    [self addChild:hsl z:10];
    */
    

    
    [self performSelector:@selector(initUIKitStuff)  withObject:nil afterDelay:0.9]; 
    
    [super onEnter];
}


-(void) initUIKitStuff {
    
    if(!myTable) {
        
        // Lanscaped so x & y coordinates swapped.
        //myTable = [[UITableView alloc] initWithFrame:CGRectMake(-63.0, 137.0, 426.0, 210.0) style:UITableViewStylePlain];
        myTable = [[UITableView alloc] initWithFrame:CGRectMake(-52.0, 152.0, 426.0, 176.0) style:UITableViewStylePlain];
        myTable.dataSource = self;
        
        CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(CC_DEGREES_TO_RADIANS(90));
        landscapeTransform = CGAffineTransformTranslate (landscapeTransform, 0.0, 0.0);
        
        [myTable setTransform:landscapeTransform];
        [[[STMAppDelegate get] window] addSubview:myTable];
    }
    
    if(!spinner) {

        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [spinner setCenter:CGPointMake(160, 240)]; // I do this because I'm in landscape mode
        [[[STMAppDelegate get] window] addSubview:spinner];
    }
}


+(ScoresLayer *) get {
    
    static ScoresLayer *instance;
    if(!instance) {
        
        instance = [[ScoresLayer alloc] init];
    }
    
    return instance;
}


-(void) goMainMenu {
    
    NSLog(@"Go to Main Menu");
    if(myTable) {
        [myTable removeFromSuperview];
        [myTable release];
    }
    
    if(spinner) {
        [spinner removeFromSuperview];
        [spinner release];
    }
    
    [STMConfig get]->b = YES;
    [[STMConfig get] setScore:0];
    
    [STMAppDelegate playEffect:kTransInfo];
    [[Director sharedDirector] replaceScene:[FadeDownTransition transitionWithDuration:[[STMConfig get] transitionDuration] scene:[[STMAppDelegate get] loadScene:kSceneMenu]]];
}

-(void) downloadScores {
    
    [spinner startAnimating];
    //[[STMAppDelegate get] requestScore];
    [self requestScore];
    [self message:@"Downloading scores"];
}


-(void) reloadTable {
    
    NSLog(@"Reload table");
    NSInteger i = [[[STMAppDelegate get] globalScores] count];
    
    if(i< 0 || i==0) {
       [self message:@"Download scores before refreshing"]; 
        
    } else {
    
        [myTable reloadData];
        [self message:@"Refreshing downloaded scores"];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    
	NSInteger i = [[[STMAppDelegate get] globalScores] count];
	NSLog(@"Number of rows: %d",i);
        
	return i;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *MyIdentifier = @"HighScoreCell";
	
	UILabel *name, *score, *idx, *country;
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
	if (cell == nil) {
        
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		
		// Position
		idx = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 4.0f, 24, kCellHeight-2)];
		idx.tag = 3;
		//		name.font = [UIFont boldSystemFontOfSize:16.0];
		idx.font = [UIFont fontWithName:@"Marker Felt" size:16.0f];
		idx.adjustsFontSizeToFitWidth = YES;
		idx.textAlignment = UITextAlignmentRight;
		idx.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
		idx.autoresizingMask = UIViewAutoresizingFlexibleRightMargin; 
		[cell.contentView addSubview:idx];
		[idx release];
		
		// Name
		name = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 4.0f, 150, kCellHeight-2)];
		name.tag = 1;
		//		name.font = [UIFont boldSystemFontOfSize:16.0];
		name.font = [UIFont fontWithName:@"Marker Felt" size:16.0f];
		name.adjustsFontSizeToFitWidth = YES;
		name.textAlignment = UITextAlignmentLeft;
		name.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
		name.autoresizingMask = UIViewAutoresizingFlexibleRightMargin; 
		[cell.contentView addSubview:name];
		[name release];
		
		// Score
		score = [[UILabel alloc] initWithFrame:CGRectMake(270, 4.0f, 70.0f, kCellHeight-2)];
		score.tag = 2;
		score.font = [UIFont systemFontOfSize:16.0f];
		score.textColor = [UIColor darkGrayColor];
		score.adjustsFontSizeToFitWidth = YES;
		score.textAlignment = UITextAlignmentRight;
		score.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
		[cell.contentView addSubview:score];
		[score release];
		
		// Flag
		country = [[UILabel alloc] initWithFrame:CGRectMake(400, 4.0f, 16, kCellHeight-2)];
		country.tag = 4;
		country.font = [UIFont systemFontOfSize:16.0f];
		country.textColor = [UIColor darkGrayColor];
		country.adjustsFontSizeToFitWidth = YES;
		country.textAlignment = UITextAlignmentRight;
		country.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
		[cell.contentView addSubview:country];
		[country release];
		
	} else {
        
		name = (UILabel *)[cell.contentView viewWithTag:1];
		score = (UILabel *)[cell.contentView viewWithTag:2];
		idx = (UILabel *)[cell.contentView viewWithTag:3];
		country = (UILabel*)[cell.contentView viewWithTag:4];
	}
	
	int i = indexPath.row;
	idx.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
	
	NSDictionary	*s = [[[STMAppDelegate get] globalScores] objectAtIndex:i];
    NSLog(@"NS Dict: %@", s);
    
	name.text = [s objectForKey:@"usr_playername"];
	score.text = [[s objectForKey:@"cc_score"] stringValue];
	country.text = [s objectForKey:@"cc_country"];
    
	return cell;
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


- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    for(UITouch *touch in touches) { 
        
        CGPoint location = [touch locationInView: [touch view]];   
        location = [[Director sharedDirector] convertCoordinate: location];
        
        for( Sprite *item in children ) { 
            
            if (item.tag != 0xFFFFFFFF) {
                
                if (CGRectContainsPoint([self rect:item], location)) { 
                    
                    if(item.tag == kDownload) {
                        
                        [ds runAction:[ScaleTo actionWithDuration:0.1 scale:1.2f]];
                        return kEventHandled;
                    }
                    
                    if(item.tag == kMainMenuG) {
                        
                        [[mm currentSprite] runAction:[ScaleTo actionWithDuration:0.1 scale:1.2f]];
                        return kEventHandled;
                    }
                }
            } 
        }
    }
    
    return kEventIgnored;
}



- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    for(UITouch *touch in touches) { 
        
        CGPoint location = [touch locationInView: [touch view]];   
        location = [[Director sharedDirector] convertCoordinate: location];
        
        for( Sprite *item in children ) { 
            
            if (item.tag != 0xFFFFFFFF) {
                
                if (CGRectContainsPoint([self rect:item], location)) { 
                    
                    if(item.tag == kReload) {
                        
                        NSLog(@"reload touched");
                        [STMAppDelegate playEffect:kEffectButton];
                        [self reloadTable];
                        return kEventHandled;
                    }
                    
                    if(item.tag == kDownload) {
                        
                        [ds runAction:[ScaleTo actionWithDuration:0.1 scale:1.0f]];
                        [STMAppDelegate playEffect:kEffectButton];
                        [self downloadScores];
                        return kEventHandled;
                    }
                    
                    if(item.tag == kMainMenuG) {
                        
                        [[mm currentSprite] runAction:[ScaleTo actionWithDuration:0.1 scale:1.0f]];
                        [STMAppDelegate playEffect:kEffectButton];
                        [self goMainMenu];
                        return kEventHandled;
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


#pragma mark -
-(void) requestScore {
	NSLog(@"Requesting scores...");
    [[ScoresLayer get] message:@"Requesting scores..."];
	ScoreServerRequest *request = [[ScoreServerRequest alloc] initWithGameName:@"STM" delegate:self];
	
	// The only supported flag as of v0.1 is kQueryFlagByCountry
	tQueryFlags flags = kQueryFlagIgnore;
	if( [STMAppDelegate get]->world == kCountry ) {
        
		flags = kQueryFlagByCountry;
    }
    
	// request All time Scores: the only supported version as of v0.1
	// request best 15 scores (limit:15, offset:0)
	[request requestScores:kQueryAllTime limit:75 offset:0 flags:flags category:@"shake"];
    
	// Release. It won't be freed from memory until the connection fails or suceeds
	[request release];
}

#pragma mark ScoreRequest Delegate
-(void) scoreRequestOk: (id) sender {
    
    [spinner stopAnimating];
	NSLog(@"score request OK");	
	NSArray *scores = [sender parseScores];	
	NSMutableArray *mutable = [NSMutableArray arrayWithArray:scores];
	
	// use the property (retain is needed)
    //[STMAppDelegate get]->globalScores = mutable;
    [[STMAppDelegate get] updateScoreArray:mutable];
	//self.globalScores = mutable;
    
    NSLog(@"\r\nScores retrieved: %@\r\n", [STMAppDelegate get]->globalScores);
    [self reloadTable];
    [self message:@"Scores downloaded"];
    
    /*
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Scores downloaded" message:@"Push the refresh button to view" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];	
     alert.tag = 0;
     [alert show];
     [alert release];
     */
}

-(void) scoreRequestFail: (id) sender {
	NSLog(@"score request fail");
    
    [spinner stopAnimating];
    [self message:@"Failed to download scores"];
    //[self reloadTable];
    
    /*
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Score Request Failed" message:@"Please connect to the internet or try again later." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];	
     alert.tag = 0;
     [alert show];
     [alert release];	
     */
}


@end
