//
//  EMMoleDelegate.h
//  wam
//
//  Created by Evan Miyaki on 3/19/14.
//  Copyright (c) 2014 chicagobulls. All rights reserved.
//

@class EMMole;

@protocol EMMoleDelegate <NSObject>

- (void)moleTapped:(EMMole *)mole;

@end

