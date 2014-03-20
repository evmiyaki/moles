//
//  EMMole.h
//  wam
//
//  Created by Evan Miyaki on 3/19/14.
//  Copyright (c) 2014 chicagobulls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMoleDelegate.h"

@interface EMMole : UIView
@property (nonatomic, weak) id<EMMoleDelegate> delegate;
- (void)move;


@end
