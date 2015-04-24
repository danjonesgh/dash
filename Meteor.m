//
//  meteor.m
//  sprite
//
//  Created by Dan Jones on 4/11/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Meteor.h"

@interface Meteor()
@property (nonatomic, retain) CCSprite *meteorSprite;
@end

@implementation Meteor

static int xPos;
@synthesize meteorSprite = _meteorSprite;

- (id) init
{
    self = [super init];
    if(self) {
        //CGSize winSize = [[CCDirector sharedDirector] viewSize];
        //xPos = winSize.width/2;
        
        [self setMeteorPosition];
        [self addChild:self.meteorSprite];
        [self runMeteorSequence];
    }
    
    return self;
}

- (void)setMeteorPosition
{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    if(xPos < winSize.width/2)
        xPos = winSize.width/2;
    
    int lowerBound = 100;
    int upperBound = 125;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    NSLog(@"x POS: %d", xPos);
    
    NSLog(@"x RAND: %d", rndValue);
    xPos += rndValue;
    
    NSLog(@"x POS222: %d", xPos);
    
    self.position = ccp(xPos, winSize.height + self.meteorSprite.contentSize.height * 2);
    self.scale = 0.2;
}

- (void)runMeteorSequence
{
    int durationLower = 3;
    int durationUpper = 7;
    int randDuration = durationLower + arc4random() % (durationUpper - durationLower);
    
    CCAction *action = [CCActionMoveTo actionWithDuration:randDuration
                                                 position:ccp(self.position.x,0)];
    
    //id callFunc = [CCActionCallFunc actionWithTarget:self selector:@selector(recycleMeteor:sp:)];
    //id sequence = [CCActionSequence actions: action, callFunc, nil];
    //[self runAction:sequence];
    [self runAction:action];
    
    // plug the hole game? -- kitchen sink/drain/black hole type of game
    
    //[sp runAction:action];
}

- (CCSprite *)meteorSprite
{
    if(_meteorSprite == nil) _meteorSprite = [CCSprite spriteWithImageNamed:@"bluecircle.png"];
    return _meteorSprite;
}

+ (id) createMeteor
{
    return [[[self class] alloc] init];
}

@end
