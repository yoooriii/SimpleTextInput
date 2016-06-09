#import "APLIndexedRange.h"
#import "APLIndexedPosition.h"

@implementation APLIndexedRange

// Class method to create an instance with a given range
+ (instancetype)indexedRangeWithRange:(NSRange)range
{
    if (range.location == NSNotFound) {
        return nil;
    }

    APLIndexedRange *indexedRange = [[self alloc] init];
    indexedRange.range = range;
    return indexedRange;
}


// UITextRange read-only property - returns start index of range.
- (UITextPosition *)start
{
    return [APLIndexedPosition positionWithIndex:self.range.location];
}


// UITextRange read-only property - returns end index of range.
- (UITextPosition *)end
{
	return [APLIndexedPosition positionWithIndex:(self.range.location + self.range.length)];
}


// UITextRange read-only property - returns YES if range is zero length.
- (BOOL)isEmpty
{
    return (self.range.length == 0);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ [%ld:%ld]", [super description], (long)self.range.location, (long)self.range.length];
}

@end
