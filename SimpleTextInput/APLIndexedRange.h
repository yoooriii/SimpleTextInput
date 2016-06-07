#import <UIKit/UIKit.h>

@interface APLIndexedRange : UITextRange

@property (nonatomic) NSRange range;
+ (instancetype)indexedRangeWithRange:(NSRange)range;

@end
