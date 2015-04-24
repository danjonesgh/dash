

#import "Box2D.h"

@interface MainScene : CCNode {
    b2World *world;
    CCNode *meteorLayer;
    //GLESDebugDraw *m_debugDraw;
    CCParallaxNode *parallaxNode;
    CCSprite *cloud1;
    CCSprite *cloud2;
}
+ (CCScene *)scene;

@end
