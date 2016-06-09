//
//  ZzStorageTest.m
//  SimpleTextInput
//
//  Created by leonid lo on 6/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

#import "ZzStorageTest.h"
#import "ExTextStorage.h"

@interface ZzStorageTest () <ExTextStorageDelegate>

@end

@implementation ZzStorageTest

- (UIImage*)resizeImage:(UIImage*)image toSize:(CGSize)size
{
    if (!image) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    [image drawInRect:(CGRect){CGPointZero, size}];
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (void)runTest1
{
    ExTextStorage* storage = [ExTextStorage new];
    storage.delegate = self;

    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"how-are-u" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName : [UIColor yellowColor], NSBackgroundColorAttributeName : [UIColor greenColor]}];
    ExTextElement* element2 = [ExTextElement elementWithAttributedString:attrStr];
    const CGSize defImgSz = CGSizeMake(32, 32);
    ExTextElement* element3 = [ExTextElement elementWithImage:[self resizeImage:[UIImage imageNamed:@"1.jpg"] toSize:defImgSz]];
    ExTextElement* element4 = [ExTextElement elementWithImage:[self resizeImage:[UIImage imageNamed:@"2.jpg"] toSize:defImgSz]];
    ExTextElement* element5 = [ExTextElement elementWithImage:[self resizeImage:[UIImage imageNamed:@"3.jpg"] toSize:defImgSz]];

    [storage appendElement:[ExTextElement elementWithString:@"hello my friend"]];
    [storage appendElement:element2];
    [storage appendElement:element3];
    [storage appendElement:[ExTextElement elementWithString:@"nice"]];
    [storage appendElement:element4];
    [storage appendElement:[ExTextElement elementWithString:@"dogs&cats"]];
    [storage appendElement:element5];
    [storage appendElement:element2];

    char textBuf[] = "C+string-example";
    for (int i=0; i<sizeof(textBuf); ++i) {
        const char ch = textBuf[i];
        if (!ch) {
            break;
        }
        ExTextElement* elementCh = [ExTextElement elementWithChar:ch];
        if (elementCh) {
            [storage appendElement:elementCh];
        }
    }

    // sym index logic
    const NSUInteger leng = storage.length;
    for (NSUInteger i=0; i<leng; ++i) {
        id sym = [storage symbolAtIndex:i];
        NSLog(@"[%03ld]'%@'", (long)i, sym);
    }


    NSString* rootDir = [@"~" stringByExpandingTildeInPath];
    NSArray* aaa = [rootDir pathComponents];
    if (aaa.count > 3) {
        NSArray* firstParts = [aaa subarrayWithRange:NSMakeRange(0, 3)];
        rootDir = [NSString pathWithComponents:firstParts];
        rootDir = [rootDir stringByAppendingPathComponent:@"Desktop/img"];
        NSError* err = nil;

        if (![[NSFileManager defaultManager] fileExistsAtPath:rootDir]) {
            if (![[NSFileManager defaultManager] createDirectoryAtPath:rootDir withIntermediateDirectories:YES attributes:nil error:&err]) {
                NSLog(@"cannot access image directory (%@)", err);
                return;
            }
        }
    }
    else {
        NSLog(@"cannot access image directory");
        return;
    }

    NSString* imagePath1 = [rootDir stringByAppendingPathComponent:@"IMG1.png"];
    NSString* imagePath2 = [rootDir stringByAppendingPathComponent:@"IMG2.png"];

    //  draw logic
    const CGSize canvasSize = CGSizeMake(512, 512);//[storage size];
    [self storage:storage writeImageAtPath:imagePath1 canvasSize:canvasSize];


    for (int ii=0; ii< storage.length/2; ++ii) {
        [storage removeSymbolAtIndex:10];
        NSLog(@"leng:%03ld", (long)storage.length);
    }

    [self storage:storage writeImageAtPath:imagePath2 canvasSize:canvasSize];
}

- (void)storage:(ExTextStorage*)storage writeImageAtPath:(NSString*)imagePath canvasSize:(CGSize)canvasSize
{
    UIGraphicsBeginImageContextWithOptions(canvasSize, YES, 2);

    [[UIColor lightGrayColor] setFill];
    UIRectFill((CGRect){CGPointZero, canvasSize});

    const CGRect drawRect = CGRectMake(20, 20, 200, 200);

    [[UIColor whiteColor] setFill];
    UIRectFill(drawRect);

    [storage drawInRect:drawRect];
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    NSError* error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:&error];
    }
    NSData* imageData = UIImagePNGRepresentation(resultImage);
    BOOL success = [imageData writeToFile:imagePath atomically:YES];
    if (!success) {
        NSLog(@"cannot save image at path '%@'", imagePath);
    }
}

#pragma mark - ExTextStorageDelegate

- (void)textStorageDidChange:(ExTextStorage*)storage
{
    NSLog(@"%@", storage);
}

@end
