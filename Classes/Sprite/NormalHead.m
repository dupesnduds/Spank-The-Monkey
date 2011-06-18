//
//	Created by Cleave Pokotea on 25/02/09
//
//	Project: Spank the Monkey
//	File: NormalHead.m
//
//	Last modified: 25/02/09
//


#import "NormalHead.h"


@implementation NormalHead


@synthesize nhAnimation;


- (void) dealloc 
{
	[nhAnimation release];
	[super dealloc];
}


-(id) init
{
	self = [super init];
	
	if (self) 
    {
		//init the counter that will be incremented to tell what frame of the animation we are on
		frameCount = 0;
		
		//For some reason if you don't start the sprite with an image you can't display the frames of an animation.
		//So we start it out with the first frame of our animation
		[self initWithFile:@"monkey_normal_open.png"];
		
		//create an Animation object to hold the frame for the walk cycle
		self.nhAnimation = [[Animation alloc] initWithName:@"nhAnimation" delay:0];
		
		//Add each frame to the animation
        [nhAnimation addFrameWithFilename:@"monkey_normal_open.png"];
		[nhAnimation addFrameWithFilename:@"monkey_normal_open.png"];
		[nhAnimation addFrameWithFilename:@"monkey_normal_blink.png"];
        [nhAnimation addFrameWithFilename:@"monkey_normal_open.png"];
        [nhAnimation addFrameWithFilename:@"monkey_normal_open.png"];
        [nhAnimation addFrameWithFilename:@"monkey_normal_open.png"];
		
		//Add the animation to the sprite so it can access it's frames
		[self addAnimation:nhAnimation];
		
		//Create a tick method to be called at the specified interval
		[self schedule: @selector(tick:) interval:0.3];
	}
	
	return self;
}


-(void) tick: (ccTime) dt 
{	
s	//reset frame counter if its past the total frames
	if(frameCount > 5) frameCount = 0;
	
	//Set the display frame to the frame in the walk animation at the frameCount index
	[self setDisplayFrame:@"nhAnimation" index:frameCount];
	
	//Increment the frameCount for the next time this method is called
	frameCount = frameCount+1;
}


@end