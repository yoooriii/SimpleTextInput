//
//  ExTextElement.m
//  SimpleTextInput
//
//  Created by leonid lo on 6/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import "ExTextElement.h"

@interface ExTextElement ()
@property (nonatomic, strong) NSString* string;
@property (nonatomic, strong) UIColor* textColor; //works for plain text only
@property (nonatomic, strong) UIFont* font; //works for plain text only
@property (nonatomic, strong) NSAttributedString* attributedString;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic) ExTextElementKind kind;
@end

@implementation ExTextElement


+ (instancetype)elementWithString:(NSString*)string
{
    ExTextElement* element = [self new];
    element.string = string;
    element.font = [UIFont systemFontOfSize:14];
    element.kind = ExTextElementKindText;
    return element;
}

+ (instancetype)elementWithAttributedString:(NSAttributedString*)attributedString
{
    ExTextElement* element = [self new];
    element.attributedString = attributedString;
    element.kind = ExTextElementKindText;
    return element;
}

+ (instancetype)elementWithImage:(UIImage*)image
{
    ExTextElement* element = [self new];
    element.image = image;
    element.kind = ExTextElementKindImage;
    return element;
}

+ (instancetype)elementWithChar:(char)charachter
{
    NSString* string = [NSString stringWithFormat:@"%c", charachter];
    if (string) {
        ExTextElement* element = [self new];
        element.image = [self imageWithString:string];
        element.kind = ExTextElementKindImage;
        return element;
    }
    return nil;
}

+ (UIImage*)imageWithString:(NSString*)string
{
    UIFont *font = [UIFont boldSystemFontOfSize:32];
    CGSize canvasSize = [string sizeWithFont:font];
    canvasSize.width += 4;
    canvasSize.height += 4;
    UIGraphicsBeginImageContextWithOptions(canvasSize, YES, 2);

    [[UIColor lightGrayColor] setFill];
    UIRectFill((CGRect){CGPointZero, canvasSize});

    UIBezierPath* bezier = [UIBezierPath bezierPathWithRoundedRect:(CGRect){CGPointZero, canvasSize} cornerRadius:4];
    bezier.lineWidth = 1;
    [[UIColor redColor] setStroke];
    [bezier stroke];

    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor whiteColor], NSBackgroundColorAttributeName : [UIColor blackColor]}];

    [attrStr drawAtPoint:CGPointMake(2, 2)];

    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return resultImage;
}

#pragma mark -

- (void)appendString:(NSString *)string
{
    if (self.string) {
        self.string = [self.string stringByAppendingString:string];

        [self.delegate textElementDidChange:self];
    }
}

- (NSUInteger)length
{
    switch (self.kind) {
        case ExTextElementKindText:
            return (nil == self.string) ? self.attributedString.length : self.string.length;

        case ExTextElementKindImage:
            return (nil == self.image) ? 0 : 1;

        default: break;
    }

    return 0;
}

- (CGSize)size
{
    CGSize size = CGSizeZero;
    switch (self.kind) {
        case ExTextElementKindText:
            if (nil == self.string) {
                if (nil != self.attributedString) {
                    size = [self.attributedString size];
                }
            }
            else
            {
                size = [self.string sizeWithFont:self.font];
            }
            break;

        case ExTextElementKindImage:
            if (nil != self.image) {
                return self.image.size;
            }
            break;

        default: break;
    }

    return size;
}

- (id)symbolAtIndex:(NSUInteger)index
{
    switch (self.kind) {
        case ExTextElementKindText:
            if (self.string) {
                return [self.string substringWithRange:NSMakeRange(index, 1)];
            }
            if (self.attributedString) {
                return [self.attributedString attributedSubstringFromRange:NSMakeRange(index, 1)];
            }
            break;

        case ExTextElementKindImage:
            NSParameterAssert(index == 0);
            return self.image;

        default: break;
    }

    return nil;
}

- (void)removeSymbolAtIndex:(NSUInteger)index
{
    if (self.kind == ExTextElementKindText) {
        if (self.string) {
            self.string = [self.string stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:@""];

            [self.delegate textElementDidChange:self];
        }
        else if (self.attributedString) {
            NSMutableAttributedString* mutableAttrStr = [self.attributedString mutableCopy];
            [mutableAttrStr replaceCharactersInRange:NSMakeRange(index, 1) withString:@""];
            self.attributedString = mutableAttrStr;

            [self.delegate textElementDidChange:self];
        }
    }
}

- (void)drawInRect:(CGRect)rect
{
    switch (self.kind) {
        case ExTextElementKindText: {
            NSAttributedString* string = self.attributedString;
            if (!string) {
                if (self.string) {
                    string = [[NSAttributedString alloc] initWithString:self.string attributes:@{NSFontAttributeName : self.font, NSForegroundColorAttributeName : [UIColor whiteColor], NSBackgroundColorAttributeName : [UIColor blackColor]}];
                }
            }

            if (string) {
                [string drawAtPoint:rect.origin];
            }
        }

        case ExTextElementKindImage:
            if (self.image) {
                CGRect drawRect;
                drawRect.origin = rect.origin;
                drawRect.size = self.size;
                [self.image drawInRect:drawRect];
            }

        default: break;
    }
}

@end
