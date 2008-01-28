#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "iPhreakApp.h"

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int ret = UIApplicationMain(argc, argv, [iPhreakApp class]);
	[pool release];
	return ret;
}
