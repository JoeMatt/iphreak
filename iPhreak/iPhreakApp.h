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
#import "PreferencesController.h"

@class TonePlayer;
@class Tone;
@class ButtonBarView;
@class UIPreferencesTable;
@class UIPreferencesTableCell;
@class UISegmentedControl;
#define UISwitchControl UISwitch

@interface iPhreakAppDelegate : NSObject <UIApplicationDelegate, UIActionSheetDelegate> {
	UIWindow		* mainWindow;
	UIView			* mainView;
	NSDictionary	* boxData;
	TonePlayer		* player;
	NSArray			* tones;
	
	UITabBarController	* tabBarController;
	
	PreferencesController *prefsController;

	UIAlertView	* warningSheet;
	
	NSMutableArray	* boxes;
	
}

-(UIWindow*)getMainWindow;
-(void)readSettings;
-(Tone*)getToneByIndex:(int) index;
-(TonePlayer*)player;

/** Button Bar **/
- (void)reloadButtonBar;
- (ButtonBarView*)createButtonBar;
@end
