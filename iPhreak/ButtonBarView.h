
/*
 * From Drunknbass: http://idevdocs.com/forum/showthread.php?t=147
 *
 *
 * project setup by Cobra
 */


#import <Foundation/Foundation.h>
#import <LayerKit/LayerKit.h>
#import <UIKit/UIKit.h>
#if 0
#import <UIKit/UIView-Geometry.h>
#import <UIKit/UIImageAndTextTableCell.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIWindow.h>
#import <UIKit/UIView.h>
#import <UIKit/UIView-Hierarchy.h>
#import <UIKit/UIView-UIImageViewImplementation.h>
#import <UIKit/UIButtonBar.h>
#import <UIKit/UINavigationBar.h>
#import <UIKit/UINavBarButton.h>
#import <UIKit/UINavigationBarBackground.h>
#import <UIKit/UINavigationItem.h>
#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTableCell.h>
#import <UIKit/UITableColumn.h>
#import <UIKit/UISegmentedControl.h>
#import <UIKit/UIPreferencesTextTableCell.h>
#import <UIKit/UIPreferencesControlTableCell.h>
#import <UIKit/UIPreferencesDeleteTableCell.h>
#import <UIKit/UISwitchControl.h>
#import <UIKit/UITransformAnimation.h>
#import <UIKit/UIKeyboard.h>
#import <UIKit/UIAnimator.h>
#import <UIKit/UIPushButton.h>
#import <UIKit/CDStructures.h>
#import <UIKit/UITextField.h>
#import <UIKit/UITransitionView.h>
#import <CoreGraphics/CoreGraphics.h>
#import <GraphicsServices/GraphicsServices.h>
#import "WebCore/WebFontCache.h"
#endif

#import <GraphicsServices/GraphicsServices.h>

@interface ButtonBarView : UIView {
	
	UITransitionView   *_transitionView;
	UITransitionView   *_barTransitionView;
	UIButtonBar        *_buttonBar;
	UIView			*testview1;
	UIView			*testview2;
	UIView			*testview3;
	UIView			*testview4;
	UIView			*testview5;
	UIView			*blankView;
	int       currentView;
	int		  barStatus;

	NSMutableArray * subviews;

	

	struct CGRect				rect;
	struct CGRect				_offScreenRect;
	struct CGRect				_onScreenRect;	
}

- (UIView*)addView: (UIView*) view;

-(id)initWithFrame:(struct CGRect)frame andView: (UIView *) aView;
- (UIButtonBar *)createButtonBar;
- (void)buttonBarItemTapped:(id)sender;
- (NSArray *)buttonBarItems;
- (void)reloadButtonBar;
- (void)mouseDown:(struct __GSEvent *)event;
- (UITransitionView *)createTransitionView;
- (UITransitionView *)createBarTransitionView;
-(void)testAnimation;

#define CB_1 0x00
#define CB_2 0x01
#define CB_3 0x02
#define CB_4 0x03
#define CB_5 0x04

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

@end //@interface ButtonBarView

