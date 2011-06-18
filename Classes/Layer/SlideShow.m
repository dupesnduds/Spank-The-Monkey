

#import "SlideShow.h"
#import "cocos2d.h"


@implementation SlideShow


- (void) dealloc {
    
    if(backgrounds) {
        
        [backgrounds release];
        backgrounds = nil;
    }
    
    if(descriptions) {
        [descriptions release];
        descriptions = nil;
    }
    
    if(background) {
        
        [background release];
        background = nil;
    }
    
    if(description) {
        
        [description release];
        description = nil;
    }
    
    if(fontName) {
        
        [fontName release];
        fontName = nil;
    }
    
    [super dealloc];
}


-(id)init {
    self = [super init];
    if (self) {
        
        /*
         * setting isTouchEnabled is the magic step that
         * allows the layer to be registered for UI events.
         * forgetting this step will lead to great confusion :-/
         */
        isTouchEnabled = YES;
        
        slidePosition = -1;
        backgrounds = [[NSMutableArray alloc] init];
        descriptions = [[NSMutableArray alloc] init];
        [self setFontName:@"Helvetica"];
        [self setFontSize:24]; 
    }
    return self;
}


- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    NSLog(@"[%s:%d] ",__FUNCTION__,__LINE__);
    /*
     *  We are using pushScene/popScene instead of replaceScene
     *  (which has superior memory usage characteristics), because
     *  it makes integrating SlideShowLayer much simpler, and helps
     *  avoid binding the code to one application without requiring
     *  us to use the delegate pattern.
     */
    if ([self hasNextSlide]) {
        
        [self displayNextSlide];
    } else {
        
        NSLog(@"pop scene [%s:%d] ",__FUNCTION__,__LINE__);
        [[Director sharedDirector] popScene];
    }
    
    return kEventHandled;
}

-(void)addSlideWithBackground: (NSString *)imageString
               andDescription: (NSString *)descString {
                   
    [[self backgrounds] addObject:imageString];
    [[self descriptions] addObject:descString];
}

-(void)displayFirstSlide {
    
    if ([[self backgrounds] count] > 0) {
        [self setSlidePosition:0];
        [self displaySlide:[self slidePosition]];
    }
}

-(void)displayNextSlide {
    
    if ([self hasNextSlide]) {
        [self setSlidePosition:[self slidePosition]+1];
        [self displaySlide:[self slidePosition]];
    }
}

-(void)displayPreviousSlide {
    
    if ([self hasPreviousSlide]) {
        [self setSlidePosition:[self slidePosition]-1];
        [self displaySlide:[self slidePosition]];
    }
}

-(void)displaySlide: (int)slideNumber {
    
    /*
     * Remove existing slide and description.
     */
    if ([self background]) {
        [self removeChild:[self background] cleanup:NO];
    }
    if ([self description]) {
        [self removeChild:[self description] cleanup:NO];
    }
    
    /*
     * Retrieve and generate necessary details for next slide.
     */
    NSString * bgString = [[self backgrounds] objectAtIndex:slideNumber];
    NSString * descString = [[self descriptions] objectAtIndex:slideNumber];
    Sprite * bg = [Sprite spriteWithFile:bgString];
    bg.position = ccp([self backgroundXPosition], [self backgroundYPosition]);
    CocosNode * desc = [Label labelWithString:descString
                                   dimensions:CGSizeMake([self descriptionWidth],
                                                         [self descriptionHeight])
                                    alignment:UITextAlignmentCenter
                                     fontName:[self fontName]
                                     fontSize:[self fontSize]];
    desc.position = ccp([self descriptionXPosition], [self descriptionYPosition]);
    
    // Add the background and desc to the layer.
    [self setBackground:bg];
    [self setDescription:desc];
    [self addChild:bg];
    [self addChild:desc];    
}

-(BOOL)hasNextSlide {
    
    return ([self slidePosition]+1 < [[self backgrounds] count]);
}

-(BOOL)hasPreviousSlide {
    
    return ([self slidePosition] > 0);
}

-(Sprite *)background {
    
    return background;
}
-(void)setBackground: (Sprite *)aSprite {
    
    if (background) [background release];
    background = [aSprite retain];
}

-(CocosNode *)description {
    
    return description;
}
-(void)setDescription: (CocosNode *)aCocosNode {
    
    if (description) [description release];
    description = [aCocosNode retain];
}

-(NSMutableArray *)backgrounds {
    
    return backgrounds;
}

-(NSMutableArray *)descriptions {
    
    return descriptions;
}

-(NSString *)fontName {
    
    return fontName;
}

-(int)fontSize {
    
    return fontSize;
}

-(void)setFontSize: (int)anInt {
    
    fontSize = anInt;
}

-(void)setFontName: (NSString *)aFontName {
    
    if (fontName) [fontName release];
    fontName = [aFontName retain];
}

-(int)slidePosition {
    
    return slidePosition;
}

-(void)setSlidePosition: (int)anInt {
    
    slidePosition = anInt;
}

-(int)backgroundXPosition {
    
    return backgroundXPosition;
}

-(void)setBackgroundXPosition: (int)anInt {
    
    backgroundXPosition = anInt;
}

-(int)backgroundYPosition {
    
    return backgroundYPosition;
}

-(void)setBackgroundYPosition: (int)anInt {
    
    backgroundYPosition = anInt;
}

-(int)descriptionXPosition {
    
    return descriptionXPosition;
}
-(void)setDescriptionXPosition: (int)anInt {
    
    descriptionXPosition = anInt;
}

-(int)descriptionYPosition {
    
    return descriptionYPosition;
}

-(void)setDescriptionYPosition: (int)anInt {
    
    descriptionYPosition = anInt;
}

-(int)descriptionWidth {
    
    return descriptionWidth;
}

-(void)setDescriptionWidth: (int)anInt {
    
    descriptionWidth = anInt;
}

-(int)descriptionHeight {
    
    return descriptionHeight;
}

-(void)setDescriptionHeight: (int)anInt {
    
    
    descriptionHeight = anInt;
}

@end
