#import "iPhreakApp.h"
#import "KeyPad.h"
#import "TonePlayer.h" 

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
#define VERSION "1.0"

@implementation iPhreakApp
 
- (void)applicationDidFinishLaunching:(UIApplication *)application
{  
    
	/* Setup Window */
	// init main window for the application to be the whole screen.
	CGRect fullscreen = [[UIScreen mainScreen] applicationFrame];
	
	[super setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	
	mainWindow = [[UIWindow alloc] initWithFrame:fullscreen];

	mainView = [[UIView alloc] initWithFrame: fullscreen];
				
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
	KeyPad * redBox    = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"RedBox"] parent:self];
	KeyPad * greenBox  = [[KeyPad alloc] initWithDictionary:[boxData objectForKey:@"GreenBox"] parent:self];

	/* Setup Views */
	//UIView * preferencesView = [self setupPreferences];
	UITextView * lcd = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];	
	tabBarController = [[UITabBarController alloc] init];
	tabBarView = tabBarController.view;
	
				/* TEMP */
	//float red[4] = {1, 0, 0, 1};
	float darkred[4] = {.3, .08, .08, 1};
	//float green[4] = {0, 1, 0, 1};
	float darkgreen[4] = {.08, .3, .08, 1};
	//float white[4] = {1, 1, 1, 1};
	//float black[4] = {0, 0, 0, 1}; 

   // [preferencesView setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), white)];
	[[redBox getView] setBackgroundColor:[UIColor redColor]];
	[[greenBox getView] setBackgroundColor:[UIColor greenColor]];
	/* END TEMP */
	
	/* Prefs */
	prefsTable    = [ self createPrefPane ];
	/* end */
	
	[lcd setTextSize:18.0];
	
	[tabBarView addView:[silverBox getView]];
	[tabBarView addView:[redBox getView]];
	[tabBarView addView:[greenBox getView]];
	[tabBarView addView:prefsTable];

	[mainView addSubview:lcd]; 
	[mainView addSubview: tabBarView];
	
	[mainWindow makeKeyAndVisible];
	[tabBarView release];
	
	// Allert sheet displayed at centre of screen.
	NSArray *buttons = [NSArray arrayWithObjects:@"I swear to be good", @"Whatever, I'll do what I want", nil];
	warningSheet = [[UIAlertView alloc] initWithTitle:@"Warning" buttons:buttons defaultButtonIndex:1 delegate:self context:self];
	[warningSheet setDelegate:self];
	[warningSheet setRunsModal: true];
	[warningSheet setBodyText:@"Be careful. Don't use for anything illegal. Avoid playing anything other than Silver Box tones into a phone receiver!"];
	[warningSheet popupAlertAnimated:YES];
}

- (void)alertSheet:(UIAlertView*)sheet buttonClicked:(int)button
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

/*** <Preferences> ****/
- (int)numberOfGroupsInPreferencesTable:(UIPreferencesTable *)aTable {
	return 2;//3;
}

- (int)preferencesTable:(UIPreferencesTable *)aTable 
    numberOfRowsInGroup:(int)group 
{
    switch (group) { 
        case(0):
            return 3;
            break;
        case(1):
            return 5;
            break;
   /*     case(2):
            return 5;
            break;
    */}
}
@class UIPreferencesTextTableCell;

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)aTable 
								cellForGroup:(int)group 
{
	if (groupcell[group] != NULL)
		return groupcell[group];
	
	groupcell[group] =  [[ UIPreferencesTextTableCell alloc ] 
						 initWithFrame: CGRectMake(0, 0, 320, 20)];
	if (group == 0) {
		[ groupcell[group] setTitle: @"General Options" ];
    }
	else if (group == 1)
		[ groupcell[group] setTitle: @"Box Enable" ];
/*	else if (group == 2)
		[ groupcell[group] setTitle: @"Stuff" ];
*/	
	return groupcell[group];
} 

- (float)preferencesTable:(UIPreferencesTable *)aTable 
			 heightForRow:(int)row 
				  inGroup:(int)group 
	   withProposedHeight:(float)proposed 
{
    if (row == -1) {
        return 40;
    }
	
	if (group == 0 && row == 2)
		return 55;
	
    return proposed;
}

- (BOOL)preferencesTable:(UIPreferencesTable *)aTable 
			isLabelGroup:(int)group 
{
    return NO; 
}

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)aTable 
								  cellForRow:(int)row 
									 inGroup:(int)group 
{
    if (cells[row][group] != NULL)
        return cells[row][group];
	
    UIPreferencesTableCell *cell;
	
    cell = [ [ UIPreferencesTableCell alloc ] init ];
	
    switch (group) {
        case (0):
			switch (row) {
				case (0):
					[ cell setTitle:@"Startup Warning" ];
					startupWarningControl =  [[ UISwitchControl alloc ] 
										initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ startupWarningControl setValue: preferences.autoSave ];
					[ cell  addSubview:startupWarningControl ]; 
					break;
				case (1):
					[ cell setTitle:@"Tone Queueing" ];
					toneQueueingControl =  [[ UISwitchControl alloc ] 
										initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ toneQueueingControl setValue: preferences.autoSave ];
					[ cell  addSubview:toneQueueingControl ]; 
					break;
				case (2):
					[ cell setTitle:@"Red Box locale" ];
					//	[ langControl selectSegment: preferences.frameSkip ];
					[ cell addSubview:langControl ];
					break;	
					
			}
			break;
			
		case (1):
			switch (row) {
					case (0):
					[ cell setTitle:@"Blue Box" ];
					blueBoxControl =  [[ UISwitchControl alloc ] 
										initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ blueBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:blueBoxControl ]; 
					break;
				case (1):
					[ cell setTitle:@"Silver Box" ];
					silverBoxControl =  [[ UISwitchControl alloc ] 
										initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ :silverBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:silverBoxControl ]; 
					break;
				case (2):
					[ cell setTitle:@"Red Box" ];
					redBoxControl =  [[ UISwitchControl alloc ] 
										initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ redBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:redBoxControl ]; 
					break;
				case (3):
					[ cell setTitle:@"Green Box" ];
					greenBoxControl =  [[ UISwitchControl alloc ] 
										initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 30.0f)];
					//[ greenBoxControl setValue: preferences.autoSave ];
					[ cell  addSubview:greenBoxControl ]; 
					break;
				case (4):
					[ cell setText:versionString ];
					break;
			}
			break;
    }
	
    [ cell setShowSelection: NO ];
    cells[row][group] = cell;
    return cells[row][group];
}

- (UIPreferencesTable *)createPrefPane {
	
	UIPreferencesTable *pref = [[UIPreferencesTable alloc] initWithFrame:
								CGRectMake(0, 0, 360, 420)];
	
    [ pref setDataSource: self ];
    [ pref setDelegate: self ];
	
    int i, j;
    for(i=0;i<10;i++)
        for(j=0;j<10;j++) 
            cells[i][j] = NULL;
	
    langControl = [[UISegmentedControl alloc]
					initWithFrame:CGRectMake(170.0f, 5.0f, 120.0f, 55.0f) ];
    [ langControl insertSegment:0 withTitle:@"US" animated: NO ];
    [ langControl insertSegment:1 withTitle:@"CAN" animated: NO ];
    [ langControl insertSegment:2 withTitle:@"GB" animated: NO ];
   // [ langControl selectSegment: preferences.frameSkip ];
	
    NSString *verString = [ [NSString alloc] initWithCString: VERSION ]; 
    versionString = [ [ NSString alloc ] initWithFormat: @"Version %@", verString ];
    [ verString release ];
	
    int row;
    for(row=0;row<6;row++) {
        UIPreferencesTableCell *cell;
        if (row > 0) {
            cell = [[UIPreferencesTextTableCell alloc] init];
        } else {
            cell = [[UIPreferencesTableCell alloc] init];
            [ cell setEnabled: YES ];
        }
		
		cells[row][2] = cell;
	
        }
    
	
    [ pref reloadData ];
    return pref;
}

- (BOOL)savePreferences
{ 
	//TODO
return YES;}


/*** </Preferences> ****/

/* <ButtonBar> */

- (void)reloadButtonBar {
    [ tabBarView removeFromSuperview ];
    [ tabBarView release ];
    tabBarView = [ self createButtonBar ];
}

- (ButtonBarView*)createButtonBar
{
	//TODO
}

/* </ButtonBar> */
@end  
