//
//  ExTextStorage.m
//  SimpleTextInput
//
//  Created by leonid lo on 6/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import "ExTextStorage.h"

@interface ExTextStorage () <ExTextElementDelegate>
@property (nonatomic, strong) NSMutableArray<ExTextElement*>* allElements;
@end

@implementation ExTextStorage

- (instancetype)init
{
    if ((self = [super init])) {
        _allElements = [NSMutableArray arrayWithCapacity:128];
    }
    return self;
}

#pragma mark - ExTextElementDelegate

- (void)textElementDidChange:(ExTextElement*)element
{
    [self.delegate textStorageDidChange:self];
}

- (CGSize)sizeInSize:(CGSize)outerSize
{
    CGSize size = CGSizeZero;

    for (ExTextElement* element in self.allElements) {
        CGSize elementSize = element.size;
        size.width += elementSize.width;
        size.height = MAX(size.height, elementSize.height);
    }

    return size;
}

- (CGSize)size
{
    return [self sizeInSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (NSUInteger)length
{
    NSUInteger length = 0;
    for (ExTextElement* element in self.allElements) {
        length += element.length;
    }
    return length;
}

- (void)appendElement:(ExTextElement*)element
{
    [self.allElements addObject:element];
    element.delegate = self;

    [self.delegate textStorageDidChange:self];
}

- (void)removeElementAtIndex:(NSUInteger)index
{
    if (index < self.allElements.count) {
        ExTextElement* element = self.allElements[index];
        element.delegate = nil;
        [self.allElements removeObjectAtIndex:index];

        [self.delegate textStorageDidChange:self];
    }
}

- (id)symbolAtIndex:(NSUInteger)index
{
    id symbol = nil;
    NSUInteger length = 0;

    for (ExTextElement* element in self.allElements) {
        const NSUInteger nextLength = length + element.length;
        if (index < nextLength) {
            const NSUInteger n = index - length;
            return [element symbolAtIndex:n];
        }
        length = nextLength;
    }

    return symbol;
}

- (void)removeSymbolAtIndex:(NSUInteger)index
{
    NSUInteger length = 0;
    ExTextElement* elementToRemove = nil;

    for (ExTextElement* element in self.allElements) {
        const NSUInteger nextLength = length + element.length;
        if (index < nextLength) {
            if (1 == element.length) {
                elementToRemove = element;
            }
            else {
                const NSUInteger n = index - length;
                [element removeSymbolAtIndex:n];
            }

            break;
        }
        length = nextLength;
    }

    if (elementToRemove) {
        [self removeElementAtIndex:[self.allElements indexOfObject:elementToRemove]];
    }
}

#pragma mark - drawing

- (void)drawInRect:(CGRect)rect
{
    CGPoint pt0 = rect.origin;
    CGFloat lineHeight = 0;

    for (ExTextElement* element in self.allElements) {
        const CGSize elementSize = element.size;
        CGRect drawRect;
        drawRect.origin = pt0;
        drawRect.size = elementSize;

        [element drawInRect:drawRect];

        pt0.x += elementSize.width;
        lineHeight = MAX(lineHeight, elementSize.height);

        const CGFloat delta = pt0.x - CGRectGetMaxX(rect);
        if (delta > 0) {
            // switch to the next line
            pt0.x = rect.origin.x;
            pt0.y += lineHeight;
            lineHeight = 0;
        }
    }
}

#pragma mark - debug

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@[%ld:%ld]:%@", [super description], (long)self.allElements.count, (long)self.length, NSStringFromCGSize([self size])];
}

@end
