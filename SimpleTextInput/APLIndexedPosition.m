#import "APLIndexedPosition.h"

@implementation APLIndexedPosition

#pragma mark IndexedPosition implementation

// Class method to create an instance with a given integer index.
+ (instancetype)positionWithIndex:(NSUInteger)index
{
    APLIndexedPosition *indexedPosition = [[self alloc] init];
    indexedPosition.index = index;
    return indexedPosition;
}

@end

