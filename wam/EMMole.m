//
//  EMMole.m
//  wam
//
//  Created by Evan Miyaki on 3/19/14.
//  Copyright (c) 2014 chicagobulls. All rights reserved.
//

#import "EMMole.h"

@interface EMMole ()
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (assign, nonatomic) NSUInteger *points;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation EMMole

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addGestureRecognizer:self.tapGesture];
    }
    return self;
}


- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    }
    return _tapGesture;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"tap mole!");
    [self removeFromSuperview];
    [self.delegate moleTapped:self];
}

- (void)move
{
    CGPoint newLoc = self.center;
    newLoc.y -= 5.0f;
    self.center = newLoc;
}

@end
