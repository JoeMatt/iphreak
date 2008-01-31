#import "iPhreakApp.h"
#import "KeyPad.h"
#import "TonePlayer.h" 
#import <UIKit/UIView-Geometry.h>
#import <UIKit/UIView-Gestures.h>
#import <UIKit/UIView-Animation.h>
#import <UIKit/UISliderControl.h>

#import <TelephonyUI/TPLCDSubImageView.h>
#import <TelephonyUI/TPLCDTextView.h>
#import <TelephonyUI/TPLCDTextViewScrollingView.h>
#import <TelephonyUI/TPLCDView.h>
#import <TelephonyUI/TelephonyUI.h>

extern NSString *kUIButtonBarButtonAction;
extern NSString *kUIButtonBarButtonInfo;
extern NSString *kUIButtonBarButtonInfoOffset;
extern NSString *kUIButtonBarButtonSelectedInfo;
extern NSString *kUIButtonBarButtonStyle;
extern NSString *kUIButtonBarButtonTag;
extern NSString *kUIButtonBarButtonTarget;
extern NSString *kUIButtonBarButtonTitle;
extern NSString *kUIButtonBarButtonTitleVerticalHeight;
extern NSString *kUIButtonBarButtonTitleWidth;
extern NSString *kUIButtonBarButtonType;

@implementation iPhreakApp
 
- (void)applicationDidFinishLaunching:(GSEventRef)event;
{  
    mainWindow = [[UIWindow alloc] initWithContentRect:[UIHardware fullScreenApplicationContentRect]];
    [mainWindow setContentView:[[[UIView alloc] initWithFrame:[mainWindow bounds]] autorelease]];
    
	[self readSettings];
	
	KeyPad * wozBox = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"WozBox"] parent:self];
	KeyPad * silverBox = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"SilverBox"] parent:self];
	
	player = [[TonePlayer alloc] init];
	
	tones = [[NSArray arrayWithObjects:
			  [player addTone: [Tone toneWithFrequency: 0]],
			  [player addTone: [Tone toneWithFrequency: 0]],
			  nil] retain];
	
	UITextView * lcd = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320.0, 80.0)];
	[lcd setTextSize:18.0];
	[[wozBox getView] addSubview:lcd];

	NSDictionary *buttonPreferences = [NSDictionary dictionaryWithObjectsAndKeys:
								 self, kUIButtonBarButtonTarget,
								 @"clearDrawing", kUIButtonBarButtonAction,
								 [NSNumber numberWithUnsignedInt:1], kUIButtonBarButtonTag,
								 [NSNumber numberWithUnsignedInt:3], kUIButtonBarButtonStyle,
								 [NSNumber numberWithUnsignedInt:1], kUIButtonBarButtonType,
								 [NSNumber numberWithUnsignedInt:75], kUIButtonBarButtonTitleWidth,
								 @"Preferences", kUIButtonBarButtonInfo,
								 nil
								 ];

	NSArray *items = [NSArray arrayWithObjects:buttonPreferences, nil];
	
	UIButtonBar *bar = [[[UIButtonBar alloc] initInView: [wozBox getView] withItemList: items] autorelease];
	float height = [UIButtonBar defaultHeight];
	[bar setOrigin: CGPointMake(0,0)];//[mainWindow bounds].size.height-height)];
	int buttons[3] = { 1, 2, 3 };
	[bar showButtons: buttons withCount: 3 withDuration: 0];
	

	/* Experimenting with varioius LCD views. All of which Bus Error on definition */
	//	TPLCDViews, i don't understand them. they just crash on decleration
	//	TPLCDSubImageView* lcd = [[[TPLCDSubImageView alloc] initWithDefaultSize] retain];
	//	[mainWindow setContentView:lcd];
	//
	//	TPLCDTextView * lcd2 = [[TPLCDTextView alloc] initWithFrame:CGRectMake(100.0, 130.0, 100.0, 50.0)];
	//	[mainWindow setContentView:lcd2];
	//
	//	TPLCDTextViewScrollingView * lcd3 = [[TPLCDTextViewScrollingView alloc] initWithFrame:CGRectMake(100.0, 130.0, 100.0, 50.0) owner:mainWindow];
	//	[mainWindow setContentView:lcd3];
	//	
	//	TPLCDView * lcd4 = [[TPLCDView alloc] initWithDefaultSize];
	//	[mainWindow setContentView:lcd4];
	//	[[wozBox getView] addSubview:lcd4];
	
	[mainWindow setContentView:[wozBox getView]];
	
	[mainWindow orderFront:self];
    [mainWindow makeKey:self];
}

-(Tone*)getToneByIndex:(int) index
{
	return [tones objectAtIndex:index];
}

-(TonePlayer*)player
{ return player; }


- (void)applicationWillTerminate;
{
	[mainWindow release];
}

-(UIWindow*)getMainWindow
{
	return mainWindow;
}

-(void)readSettings
{
	boxData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Boxes" ofType: @"plist"] ];
	
	if(boxData == nil)
	{
		NSLog(@"Error reading Boxes.plist");
		[boxData release];
	}
}

@end  
