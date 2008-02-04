#import <Foundation/Foundation.h>
#import <GraphicsServices/GraphicsServices.h>
#import <LayerKit/LayerKit.h>
#import <UIKit/UIKit.h>

@class TonePlayer;
@class Tone;
@class ButtonBarView;

@interface iPhreakApp : UIApplication {
	UIWindow *mainWindow;
	UIView  *mainView;
	NSDictionary * boxData;
	TonePlayer * player;
	NSArray *tones;
	
	ButtonBarView * buttonBarView;
}

-(UIWindow*)getMainWindow;
-(void)readSettings;
-(Tone*)getToneByIndex:(int) index;
-(TonePlayer*)player;
- (void)alertSheet:(UIAlertSheet*)sheet buttonClicked:(int)button;

@end
