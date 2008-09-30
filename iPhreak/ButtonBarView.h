
/*
 * From Drunknbass: http://idevdocs.com/forum/showthread.php?t=147
 *
 *
 * project setup by Cobra
 */

#import <UIKit/UIKit.h>
@class UITransitionView;

@interface ButtonBarView : UIView {
	
	UITransitionView   *_transitionView;
	UITransitionView   *_barTransitionView;
	UITabBar        *_buttonBar;
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
- (UITabBar *)createButtonBar;
- (void)buttonBarItemTapped:(id)sender;
- (NSArray *)buttonBarItems;
- (void)reloadButtonBar;
- (void)mouseDown:(struct __GSEvent *)event;
- (UITransitionView *)createTransitionView;
- (UITransitionView *)createBarTransitionView;
-(void)testAnimation;

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

