//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: HitHead.m
//
//	Last modified: 25/02/09
//

#import "HitHead.h"


@implementation HitHead


@synthesize hhAnimation;


- (void) dealloc {
    
	[hhAnimation release];
	[super dealloc];
}


-(id) init {
	self = [super init];
	
	if (self) {
        //*
		//init the counter that will be incremented to tell what frame of the animation we are on
		frameCount = 0;
		
		//For some reason if you don't start the sprite with an image you can't display the frames of an animation.
		//So we start it out with the first frame of our animation
		[self initWithFile:@"monkey_surprise_open.png"];
		
		//create an Animation object to hold the frame for the walk cycle
		self.hhAnimation = [[Animation alloc] initWithName:@"hhAnimation" delay:0];
		
		//Add each frame to the animation
        [hhAnimation addFrameWithFilename:@"monkey_surprise_open.png"];
		[hhAnimation addFrameWithFilename:@"monkey_surprise_open.png"];
		[hhAnimation addFrameWithFilename:@"monkey_surprise_blink.png"];
        [hhAnimation addFrameWithFilename:@"monkey_surprise_open.png"];
        [hhAnimation addFrameWithFilename:@"monkey_surprise_open.png"];
        [hhAnimation addFrameWithFilename:@"monkey_surprise_open.png"];
		
		//Add the animation to the sprite so it can access it's frames
		[self addAnimation:hhAnimation];
        
        [self schedule: @selector(tick:) interval:0.3];
		//*/
	}
	
	return self;
}


//*
-(void) tick: (ccTime) dt {	
    
	//reset frame counter if its past the total frames
	if(frameCount > 5) frameCount = 0;
	
	//Set the display frame to the frame in the walk animation at the frameCount index
	[self setDisplayFrame:@"hhAnimation" index:frameCount];
	
	//Increment the frameCount for the next time this method is called
	frameCount = frameCount+1;
}
//*/

@end