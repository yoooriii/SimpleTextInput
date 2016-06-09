//
//  ExTextStorage.h
//  SimpleTextInput
//
//  Created by leonid lo on 6/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExTextElement.h"

@class ExTextStorage;

@protocol ExTextStorageDelegate <NSObject>

- (void)textStorageDidChange:(ExTextStorage*)storage;

@end

@interface ExTextStorage : NSObject

@property (nonatomic, weak) id<ExTextStorageDelegate> delegate;
@property (nonatomic, readonly) NSUInteger length;

- (void)appendElement:(ExTextElement*)element;

- (void)removeElementAtIndex:(NSUInteger)index;

- (id)symbolAtIndex:(NSUInteger)index;
- (void)removeSymbolAtIndex:(NSUInteger)index;


- (CGSize)size;
- (CGSize)sizeInSize:(CGSize)outerSize;

- (void)drawInRect:(CGRect)rect;

@end
