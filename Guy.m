//
//  Guy.m
//  sprite
//
//  Created by Dan Jones on 3/28/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Guy.h"

@interface Guy()
@property (nonatomic, retain) CCSprite *guySprite;
@end

@implementation Guy

@synthesize guySprite = _guySprite;

- (id) init
{
    self = [super init];
    if(self) {
        [self setGuySpritePosition];
        [self addChild:self.guySprite];
    }
    
    return self;
}

- (void)setGuySpritePosition
{
    CGSize s = [[CCDirector sharedDirector] viewSize];
    self.guySprite.position = ccp(s.width * 0.1, s.height * 0.38);
    self.guySprite.scale = 0.1f;
}

- (CCSprite *)guySprite
{
    if(_guySprite == nil) _guySprite = [CCSprite spriteWithImageNamed:@"fox-landscape-pieces.png"];
    return _guySprite;
}

+ (id) createGuy
{
    return [[[self class] alloc] init];
}

@end
