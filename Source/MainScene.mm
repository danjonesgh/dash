#import "MainScene.h"
#import "Guy.h"
#import "Meteor.h"

@interface MainScene()
@property (nonatomic) NSInteger currentXPos;
@property (nonatomic, retain) NSMutableArray *clouds;
@end
#define PTM_RATIO 32.0

@implementation MainScene
- (id) init
{
    self = [super init];
    if(!self) return nil;
    
    
    b2Vec2 gravity;
    gravity.Set(0.0f, -5.0f);
    world = new b2World(gravity);
    
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    self.clouds = [[NSMutableArray alloc] init];
    
    self.currentXPos = viewSize.width/2;
    Guy *newGuy = [Guy createGuy];
    [self addChild:newGuy];
    [self setGround];
    [self createMeteorLayer];
    [self createMeteorPool];
    
    
    [self createParallaxBackground];
    
    return self;
}

- (void)createParallaxBackground
{
    parallaxNode = [CCParallaxNode node];
    [meteorLayer addChild:parallaxNode z:-1];
    [self addClouds];
}

- (void)addClouds
{
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    cloud1 = [CCSprite spriteWithImageNamed:@"cloud.png"];
    cloud2 = [CCSprite spriteWithImageNamed:@"cloud2.png"];
    
    [self.clouds addObject:cloud1];
    [self.clouds addObject:cloud2];
    
    cloud1.scale = 0.2;
    cloud2.scale = 0.1;
    
    CGPoint cloud1ratio = ccp(0.5, 0.5);
    CGPoint cloud2ratio = ccp(0.6, 0.6);
    [parallaxNode addChild:cloud1 z:-1 parallaxRatio:cloud1ratio positionOffset:ccp(0,viewSize.height*0.75)];
    [parallaxNode addChild:cloud2 z:-1 parallaxRatio:cloud2ratio positionOffset:ccp(600, viewSize.height*0.65)];
}

- (void)update:(CCTime)delta
{
    meteorLayer.position = ccpAdd(meteorLayer.position, ccpMult(ccp(-50,0), delta));
    
    if(cloud1.position.x < 0)
    {
        cloud1.position = ccp([[CCDirector sharedDirector] viewSize].width,
                              [[CCDirector sharedDirector] viewSize].height*0.5);
    }
}

- (void)createMeteorLayer
{
    meteorLayer = [CCNode node];
    [self addChild:meteorLayer z:-1];
}

- (void)createMeteorPool
{
    for(int i = 0; i < 20; i++) {
        Meteor *m = [Meteor createMeteor];
        [meteorLayer addChild:m z:1];
        //[self createMeteor];
    }
}

- (void)runMeteorSequence:(CCSprite *)meteor
{
    int durationLower = 3;
    int durationUpper = 7;
    int randDuration = durationLower + arc4random() % (durationUpper - durationLower);
    
    CCAction *action = [CCActionMoveTo actionWithDuration:randDuration
                                                 position:ccp(meteor.position.x,0)];
    
    //id callFunc = [CCActionCallFunc actionWithTarget:self selector:@selector(recycleMeteor:sp:)];
    //id sequence = [CCActionSequence actions: action, callFunc, nil];
    //[meteor runAction:sequence];
    
    // plug the hole game? -- kitchen sink/drain/black hole type of game
    
    //[sp runAction:action];
}

- (void)recycleMeteor:(CCSprite *)meteor
{
    
}

- (void)createMeteor
{

}

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    MainScene *m = [MainScene node];
    [scene addChild:m];
    
    // return the scene
    return scene;
}

- (void)setGround
{
    CCSprite *ground = [CCSprite spriteWithImageNamed:@"ground.png"];
    CGSize s = [[CCDirector sharedDirector] viewSize];
    ground.position = ccp(s.width * 0.5, 0);
    ground.scale = 0.6;
    [self addChild:ground];
    
}
@end
