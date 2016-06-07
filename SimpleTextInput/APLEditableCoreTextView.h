#import <UIKit/UIKit.h>

#import "APLSimpleCoreTextView.h"

@class APLEditableCoreTextView;

// APLEditableCoreTextViewDelegate - simple delegate protocol to notify when the APLEditableCoreTextView
// becomes first responder
@protocol APLEditableCoreTextViewDelegate 
- (void)editableCoreTextViewWillEdit:(APLEditableCoreTextView *)editableCoreTextView;
@end


// APLEditableCoreTextView - Main custom text view that handles text input and draws text
// (using contained APLSimpleCoreTextView)
@interface APLEditableCoreTextView : UIView <UITextInput> 

@property (nonatomic, weak) IBOutlet id <APLEditableCoreTextViewDelegate> editableCoreTextViewDelegate;

@end
