#import "iPhreakApp.h"
#import "KeyPadView.h"
#import "TonePlayer.h" 
#import "KeyPadController.h"

#import "ButtonBarView.h"

@implementation iPhreakAppDelegate
 
- (void)applicationDidFinishLaunching:(UIApplication *)application
{  
    
	/* Setup Window */
	// init main window for the application to be the whole screen.
	CGRect fullscreen = [[UIScreen mainScreen] applicationFrame];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	
	mainWindow = [[UIWindow alloc] initWithFrame:fullscreen];

	mainView = [[UIView alloc] initWithFrame: fullscreen];
	[mainWindow addSubview:mainView];
	[mainView release];
				
	[self readSettings];

	/* Setup Oscilators */
//	player = [[TonePlayer alloc] init];
//	
//	tones = [[NSArray arrayWithObjects:
//			  [player addTone: [Tone toneWithFrequency: 0]],
//			  [player addTone: [Tone toneWithFrequency: 0]],
//			  nil] retain];
//	[player play];
	
	/* Create Boxes */
	KeyPadController * wozBox    = [[KeyPadController alloc] initWithDictionary:[boxData objectForKey:@"WozBox"] parent:self];
	KeyPadController * silverBox = [[KeyPadController alloc] initWithDictionary:[boxData objectForKey:@"SilverBox"] parent:self];
	KeyPadController * redBox    = [[KeyPadController alloc] initWithDictionary:[boxData objectForKey:@"RedBox"] parent:self];
	KeyPadController * greenBox  = [[KeyPadController alloc] initWithDictionary:[boxData objectForKey:@"GreenBox"] parent:self];
	
	/* Setup Views */
	//UIView * preferencesView = [self setupPreferences];
	UITextView * lcd = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];	

	/* END TEMP */
	
	/* Prefs */
	prefsController    = [[PreferencesController alloc] init];
	/* end */
	
	/* Tabbar */
	tabBarController = [[UITabBarController alloc] init];
	UIView * tabBarView = tabBarController.view;
	
	boxes = [[NSArray alloc] initWithObjects:wozBox, silverBox, redBox, greenBox, prefsController];
	[tabBarController setViewControllers:boxes animated:NO];
	/* end */
	
	lcd.font = [UIFont systemFontOfSize:18.0];
	

	[mainView addSubview:lcd]; 
	[mainView addSubview: tabBarView];
	
	[mainWindow makeKeyAndVisible];
	[tabBarView release];
	
	// Allert sheet displayed at centre of screen.
	warningSheet = [[UIAlertView alloc] initWithTitle:@"Warning"
											  message:@"Be careful. Don't use for anything illegal. Avoid playing anything other than Silver Box tones into a phone receiver!" 
											 delegate:self 
									cancelButtonTitle:@"Whatever, I'll do what I want" 
									otherButtonTitles:@"I swear to be good",nil];
	[warningSheet show];				
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{	
	switch(buttonIndex)
	{
		case 0:
			[[UIApplication sharedApplication] terminateWithSuccess];
			break;
		case 1:
			break;
	}
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


/* <ButtonBar> */

- (void)reloadButtonBar {
    [tabBarController.view removeFromSuperview ];
	tabBarController.view = [ self createButtonBar ];
}

- (ButtonBarView*)createButtonBar
{
	//TODO
	return nil;
}

/* </ButtonBar> */
@end  
