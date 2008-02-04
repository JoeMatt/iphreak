#import "iPhreakApp.h"
#import "KeyPad.h"
#import "TonePlayer.h" 
#import <UIKit/UIView-Geometry.h>
#import <UIKit/UIView-Gestures.h>
#import <UIKit/UIView-Animation.h>
#import <UIKit/UISliderControl.h>

#import "ButtonBarView.h"

/*
#import <TelephonyUI/TPLCDSubImageView.h>
#import <TelephonyUI/TPLCDTextView.h>
#import <TelephonyUI/TPLCDTextViewScrollingView.h>
#import <TelephonyUI/TPLCDView.h>
#import <TelephonyUI/TelephonyUI.h>
 */
/*
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
*/
@implementation iPhreakApp
 
- (void)applicationDidFinishLaunching:(GSEventRef)event;
{  
    
	/* Setup Window */
	// init main window for the application to be the whole screen.
	//struct CGRect frame = [UIHardware fullScreenApplicationContentRect];
	//frame.origin.x = frame.origin.y = 0.0f;
	//mainWindow = [[UIWindow alloc] initWithContentRect: frame];

	mainWindow = [[UIWindow alloc] initWithContentRect:[UIHardware fullScreenApplicationContentRect]];
    [mainWindow setContentView:[[[UIView alloc] initWithFrame:[mainWindow bounds]] autorelease]];
	mainView = [[[UIView alloc] initWithFrame:[mainWindow bounds]] autorelease];
	[mainWindow setContentView:mainView];
				
	[self readSettings];

	/* Setup Oscilators */
	player = [[TonePlayer alloc] init];
	
	tones = [[NSArray arrayWithObjects:
			  [player addTone: [Tone toneWithFrequency: 0]],
			  [player addTone: [Tone toneWithFrequency: 0]],
			  nil] retain];
	[player play];
	
	/* Create Boxes */
	KeyPad * wozBox    = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"WozBox"] parent:self];
	KeyPad * silverBox = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"SilverBox"] parent:self];
//	KeyPad * redBox    = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"SilverBox"] parent:self];
//	KeyPad * greenBox  = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"SilverBox"] parent:self];
  	
	// Experimenting with varioius LCD views. All of which Bus Error on definition 
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

	/* Setup Views */
	[super setStatusBarMode:3 duration:0];

	UIView * preferencesView = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
	UITextView * lcd = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];	
	buttonBarView = [[ButtonBarView alloc] initWithFrame:CGRectMake(0,0,320,460) andView:[wozBox getView]];
	
				/* TEMP */
	float red[4] = {1, 0, 0, 1};
	float green[4] = {0, 1, 0, 1};
	float white[4] = {1, 1, 1, 1};
	UIView * redBoxFiller = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
	UIView * greenBoxFiller = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
	[redBoxFiller setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), red)];
    [greenBoxFiller setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), green)];
    [preferencesView setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), white)];
				/* END TEMP */
	
	[lcd setTextSize:18.0];
	
	[buttonBarView addView:[silverBox getView]];
	[buttonBarView addView:redBoxFiller];
	[buttonBarView addView:greenBoxFiller];
	[buttonBarView addView:preferencesView];

	[mainView addSubview:lcd]; 
	[mainView addSubview:buttonBarView];
	
	[mainWindow orderFront: self];
	[mainWindow makeKey: self];
	[mainWindow _setHidden: NO];
	[buttonBarView release];
	
	// Allert sheet displayed at centre of screen.
	NSArray *buttons = [NSArray arrayWithObjects:@"I swear to be good", @"Whatever, I'll do what I want", nil];
	UIAlertSheet *alertSheet = [[UIAlertSheet alloc] initWithTitle:@"Warning" buttons:buttons defaultButtonIndex:1 delegate:self context:self];
	[alertSheet setDelegate:self];
	[alertSheet setRunsModal: true];
	[alertSheet setBodyText:@"Be careful. Don't use for anything illegal. Avoid playing anything other than Silver Box tones into a phone receiver!"];
	[alertSheet popupAlertAnimated:YES];
}

- (void)alertSheet:(UIAlertSheet*)sheet buttonClicked:(int)button
{
	if ( button == 1 )
		;
	else if ( button == 2 )
	{ [self terminateWithSuccess]; }
	
	[sheet dismiss];
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
