#import <UIKit/UIKit.h>


int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int ret = UIApplicationMain(argc, argv, @"UIApplication", @"iPhreakAppDelegate");
	[pool release];
	return ret;
}
