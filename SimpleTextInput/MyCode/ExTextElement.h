//
//  ExTextElement.h
//  SimpleTextInput
//
//  Created by leonid lo on 6/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(short, ExTextElementKind)
{
    ExTextElementKindUndefined,
    ExTextElementKindText,
    ExTextElementKindImage
};

@class ExTextElement;

@protocol ExTextElementDelegate <NSObject>

- (void)textElementDidChange:(ExTextElement*)element;

@end

@interface ExTextElement : NSObject

+ (instancetype)elementWithString:(NSString*)string;
+ (instancetype)elementWithAttributedString:(NSAttributedString*)string;
+ (instancetype)elementWithImage:(UIImage*)image;
+ (instancetype)elementWithChar:(char)charachter;

@property (nonatomic, weak) id<ExTextElementDelegate> delegate;
@property (nonatomic, readonly) NSUInteger length;
@property (nonatomic, readonly) ExTextElementKind kind;
@property (nonatomic, readonly) CGSize size;

- (void)appendString:(NSString*)string;
- (id)symbolAtIndex:(NSUInteger)index;
- (void)removeSymbolAtIndex:(NSUInteger)index;

- (void)drawInRect:(CGRect)rect;

@end
