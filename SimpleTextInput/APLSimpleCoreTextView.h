#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>


@interface APLSimpleCoreTextView : UIView

@property (nonatomic, copy) NSString *contentText; // The text content (without attributes).
@property (nonatomic, strong) UIFont *font; // Font used for text content.
@property (nonatomic, getter=isEditing) BOOL editing; // Is view in "editing" mode or not (affects drawn results).
@property (nonatomic) NSRange markedTextRange; // Marked text range (for input method marked text).
@property (nonatomic) NSRange selectedTextRange; // Selected text range.

- (CGRect)caretRectForIndex:(int)index;
- (CGRect)firstRectForRange:(NSRange)range;
- (NSInteger)closestIndexToPoint:(CGPoint)point;

+ (UIColor *)caretColor;

@end
