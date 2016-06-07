#import "APLSimpleCaretView.h"
#import "APLSimpleCoreTextView.h"


static const NSTimeInterval InitialBlinkDelay = 3;//0.7;
static const NSTimeInterval BlinkRate = 0.5;



@interface APLSimpleCaretView ()

@property (nonatomic) CAAnimation* blinkAnimation;

@end



@implementation APLSimpleCaretView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [APLSimpleCoreTextView caretColor];

        _blinkAnimation = [self createBlinkAnimation];
    }
    return self;
}

- (CAAnimation*)createBlinkAnimation
{
    CABasicAnimation* blinkAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    blinkAnimation.fromValue = @(1);
    blinkAnimation.toValue = @(0.1);
    blinkAnimation.duration = BlinkRate;
    blinkAnimation.repeatCount = HUGE_VALF;
    return blinkAnimation;
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self.layer addAnimation:self.blinkAnimation forKey:@"opacity"];
    }
    else {
        [self.layer removeAnimationForKey:@"opacity"];
    }
}


// Helper method to set an initial blink delay
- (void)delayBlink
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    [self.layer removeAllAnimations];
    self.blinkAnimation = [self createBlinkAnimation];
    self.blinkAnimation.beginTime = InitialBlinkDelay;
    [self.layer addAnimation:self.blinkAnimation forKey:@"opacity"];
}

@end

