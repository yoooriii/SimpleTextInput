//
//  MyTokenizer.m
//  SimpleTextInput
//
//  Created by leonid lo on 6/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import "MyTokenizer.h"

@implementation MyTokenizer

#pragma mark - UITextInputTokenizer

// Returns range of the enclosing text unit of the given granularity, or nil if there is no such enclosing unit.  Whether a boundary position is enclosed depends on the given direction, using the same rule as isPosition:withinTextUnit:inDirection:
- (nullable UITextRange *)rangeEnclosingPosition:(UITextPosition *)position withGranularity:(UITextGranularity)granularity inDirection:(UITextDirection)direction
{
    UITextRange* range = [super rangeEnclosingPosition:position withGranularity:granularity inDirection:direction];
    return range;
}

// Returns YES only if a position is at a boundary of a text unit of the specified granularity in the particular direction.
- (BOOL)isPosition:(UITextPosition *)position atBoundary:(UITextGranularity)granularity inDirection:(UITextDirection)direction
{
    const BOOL isPos = [super isPosition:position atBoundary:granularity inDirection:direction];
    return isPos;
}

// Returns the next boundary position of a text unit of the given granularity in the given direction, or nil if there is no such position.
- (nullable UITextPosition *)positionFromPosition:(UITextPosition *)position toBoundary:(UITextGranularity)granularity inDirection:(UITextDirection)direction
{
    UITextPosition* pos2 = [super positionFromPosition:position toBoundary:granularity inDirection:direction];
    return pos2;
}

// Returns YES if position is within a text unit of the given granularity.  If the position is at a boundary, returns YES only if the boundary is part of the text unit in the given direction.
- (BOOL)isPosition:(UITextPosition *)position withinTextUnit:(UITextGranularity)granularity inDirection:(UITextDirection)direction
{
    const BOOL isPos = [super isPosition:position withinTextUnit:granularity inDirection:direction];
    return isPos;
}

@end
