#import "APLIndexedPosition.h"

@implementation APLIndexedPosition

#pragma mark IndexedPosition implementation

// Class method to create an instance with a given integer index.
+ (instancetype)positionWithIndex:(NSInteger)index
{
    APLIndexedPosition *indexedPosition = [[self alloc] init];
    indexedPosition.index = index;
    return indexedPosition;
}

- (NSComparisonResult)compareToPosition:(APLIndexedPosition*)other
{
    APLIndexedPosition *indexedPosition = self;
    APLIndexedPosition *otherIndexedPosition = other;

    if (indexedPosition.index < otherIndexedPosition.index) {
        return NSOrderedAscending;
    }
    if (indexedPosition.index > otherIndexedPosition.index) {
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ [%ld]", [super description], (long)self.index];
}

@end

