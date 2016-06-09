#import <Foundation/Foundation.h>

@interface APLIndexedPosition : UITextPosition

@property (nonatomic) NSInteger index;
@property (nonatomic) id <UITextInputDelegate> inputDelegate;

+ (instancetype)positionWithIndex:(NSInteger)index;

- (NSComparisonResult)compareToPosition:(APLIndexedPosition*)other;

@end
