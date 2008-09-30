/*
 iPhreak.app
 Copyright (c) 2008, Joseph Mattiello
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; version 2
 of the License.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 
 */

#ifdef DEBUG
#define DLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DLog(...) 
#endif

#import <UIKit/UIKit.h>

@class TonePlayer;
@class Tone;
@class ButtonBarView;
@class UIPreferencesTable;
@class UIPreferencesTableCell;
@class UISegmentedControl;
#define UISwitchControl UISwitch

@interface iPhreakApp : UIApplication {
	UIWindow		* mainWindow;
	UIView			* mainView;
	NSDictionary	* boxData;
	TonePlayer		* player;
	NSArray			* tones;
	
	UITabBarController	* tabBarController;
	UITabBar			* tabBarView;
	
	UIAlertView	* warningSheet;
	
	NSMutableArray	* boxes;
	
	/* Preferences */
	UIPreferencesTable *prefsTable;
	
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

-(UIWindow*)getMainWindow;
-(void)readSettings;
-(Tone*)getToneByIndex:(int) index;
-(TonePlayer*)player;
- (void)alertSheet:(UIAlertView*)sheet buttonClicked:(int)button;

/** Button Bar **/
- (void)reloadButtonBar;
- (ButtonBarView*)createButtonBar;

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
