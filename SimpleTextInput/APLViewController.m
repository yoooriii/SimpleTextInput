#import "APLViewController.h"
#import "APLEditableCoreTextView.h"

@interface APLViewController ()

@property (nonatomic, weak) IBOutlet APLEditableCoreTextView *editableCoreTextView;

@end


@implementation APLViewController

/*
 Action method to handle when user presses "Done" button in NavBar.
 We want to resignFirstResponder in our APLEditableCoreTextView and remove the Done button.
 */
- (void)doneEditingAction:(id)sender
{
	// Finish typing text/dismiss the keyboard by removing it as the first responder.
	[self.editableCoreTextView resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

/*
 Protocol method called after APLEditableCoreTextView has determined that user has invoked "edit" mode (via touching inside APLEditableCoreTextView). For this sample we provide a "Done" button at this point that the user can use to finish text editing mode.
 */
- (void)editableCoreTextViewWillEdit:(APLEditableCoreTextView *)editableCoreTextView;
{
	// Show a "Done" button to dismiss the keyboard.
	UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditingAction:)];
	self.navigationItem.rightBarButtonItem = doneItem;
}


@end
