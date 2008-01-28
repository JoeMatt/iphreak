#import <Foundation/Foundation.h>
#import <GraphicsServices/GraphicsServices.h>
#import <LayerKit/LayerKit.h>
#import <UIKit/UIKit.h>
#import "TonePlayer.h"

@interface iPhreakApp : UIApplication {
	UIWindow *mainWindow;
	NSDictionary * boxData;
	TonePlayer * player;
	NSArray *tones;
}

-(UIWindow*)getMainWindow;
-(void)readSettings;
-(Tone*)getToneByIndex:(int) index;
-(TonePlayer*)player;

@end
