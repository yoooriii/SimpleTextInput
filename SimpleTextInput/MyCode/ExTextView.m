//
//  ExTextView.m
//  SimpleTextInput
//
//  Created by leonid lo on 6/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import "ExTextView.h"
#import "ExTextStorage.h"

@implementation ExTextView

- (void)drawRect:(CGRect)rect {
    UIColor* bgColor = self.backgroundColor;
    if (!bgColor) {
        bgColor = [UIColor lightGrayColor];
    }
    [bgColor setFill];
    UIRectFill(rect);

    if (self.storage) {
        [self.storage drawInRect:rect];
    }
}

@end
