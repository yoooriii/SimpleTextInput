#import "APLAppDelegate.h"
#import "ZzStorageTest.h"

@implementation APLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ZzStorageTest* test = [ZzStorageTest new];
    [test runTest1];

    return YES;
}

@end
