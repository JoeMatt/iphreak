//
//  PreferencesController.h
//  iPhreak
//
//  Created by Joseph Mattiello on 10/5/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIPreferencesTable;
@class UIPreferencesTableCell;
@class UISegmentedControl;
#define UISwitchControl UISwitch

@interface PreferencesController : UITableViewController {
	/* Preferences */
	
	UIPreferencesTableCell *cells[10][10];
	UIPreferencesTableCell *groupcell[10];
	UISegmentedControl *langControl;
	UISwitchControl *toneQueueingControl;
	UISwitchControl *startupWarningControl;
	UISwitchControl *blueBoxControl;
	UISwitchControl *redBoxControl;
	UISwitchControl *silverBoxControl;
	UISwitchControl *greenBoxControl;
	NSString *versionString;
	/* End Preferences */
}

/* <Preferences> */
- (BOOL)					savePreferences;
- (UIPreferencesTable *)	createPrefPane;
- (int)						numberOfGroupsInPreferencesTable: (UIPreferencesTable *)aTable;
- (int)						preferencesTable:(UIPreferencesTable *)aTable 
		  numberOfRowsInGroup:(int)group;

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)aTable 
								cellForGroup:(int)group;

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)aTable 
								  cellForRow:(int)row 
									 inGroup:(int)group;

- (float)					preferencesTable:(UIPreferencesTable *)aTable 
				  heightForRow:(int)row 
					   inGroup:(int)group 
			withProposedHeight:(float)proposed;

- (BOOL)preferencesTable:(UIPreferencesTable *)aTable isLabelGroup:(int)group;
/* </Preferences> */
@end
