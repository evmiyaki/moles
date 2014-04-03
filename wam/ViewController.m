//
//  ViewController.m
//  wam
//
//  Created by Evan Miyaki on 3/19/14.
//  Copyright (c) 2014 chicagobulls. All rights reserved.
//

#import "EMMole.h"
#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *moles;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (assign, nonatomic) NSUInteger points;
@property (assign, nonatomic) NSUInteger health;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UILabel *healthlabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *molepic;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.moles = [NSMutableArray array];
//    self.molepic = [NSArray array];
    self.health = 100;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self startTickerLoop];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

// How to make mole
-(void)createMoleAtLocation:(CGPoint)location
{
    EMMole *mole= [[EMMole alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    mole.center = location;
    mole.backgroundColor = [UIColor colorWithHue:((arc4random()%10)/10.0) saturation:arc4random() brightness:arc4random() alpha:1];
    mole.delegate = self;
    [self.view addSubview:mole];
    [self.moles addObject:mole];
}

//// How to make mole
//-(void)createMoleAtLocation:(CGPoint)location
//{
//    EMMole *mole= [[EMMole alloc] *molepic]
//    mole.center = location;
//    mole.delegate = self;
//    [self.view addSubview:mole];
//    [self.moles addObject:mole];
//}

// Creates mole
- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.view];
    [self createMoleAtLocation:location];
}

// Do things every frame
- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(tick:)];
        _displayLink.frameInterval = 1.0f/60.0f;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
        _displayLink.paused = YES;
    }
    return _displayLink;
}

// Start displayLink
- (void)startTickerLoop
{
    self.displayLink.paused = NO;
}

// Stop displayLink
- (void)stopTickerLoop
{
    self.displayLink.paused = YES;
}

// Declares move (how the moles will move)
- (void)tick:(CADisplayLink *)sender
{
    for (EMMole *mole in self.moles){
        [mole move];
    }
    
    [self removeDeadMoles];
    
}

// Gets rid of moles once they go past the edge of the screen
- (void)removeDeadMoles
{
    NSMutableArray *discardedMoles = [NSMutableArray array];
    
    for (EMMole *mole in self.moles) {
        if (!CGRectIntersectsRect(self.view.bounds, mole.frame) || !mole.superview) {
            // Increment the tally:
            self.health = self.health - 1;
            
            // Show the new health:
            self.healthlabel.text = [NSString stringWithFormat:@"Health: %i", self.health];
            [mole removeFromSuperview];
            [discardedMoles addObject:mole];
            NSLog(@"Removing mole -- count: %i", [self.moles count]);
        }
    }
    [self.moles removeObjectsInArray:discardedMoles];
     }



#pragma mark - Mole delegates
// Give points
- (void)moleTapped:(EMMole *)mole
{
    
    // Increment the tally:
    self.points = self.points + 1;
    
//    // Show the new score:
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", self.points];
    
}


@end
