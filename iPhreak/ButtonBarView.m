/*
 * From Drunknbass: http://idevdocs.com/forum/showthread.php?t=147
 *
 *
 * project setup by Cobra
 * added window and app support
 */

#import "ButtonBarView.h"

/*
 * ButtonBarView
 */
@implementation ButtonBarView

-(id)initWithFrame:(CGRect)frame andView: (UIView *) aView
{
	if ((self == [super initWithFrame:frame])!=nil) {
	
	barStatus = 1;

	rect = [UIHardware fullScreenApplicationContentRect];
	_offScreenRect = frame;
	_onScreenRect = frame;
	_onScreenRect.origin.x = 0.0f;
	rect.origin.x = rect.origin.y = 0.0f;
	
// Create some colors
	/* float cyan[4] = {0, 0.6823, 0.9372, 1};
	 float yellow[4] = {1, 0.9490, 0, 1};
	 float magenta[4] = {0.9254, 0, 0.5490, 1};
	 float orange[4] = {1.0, 0.6588, 0, 1};
	 float white[4] = {1, 1, 1, 1};
	*/
// Create your views
/*	testview1 = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
	testview2 = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
	testview3 = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
	testview4 = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
	testview5 = [ [ UIView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
    [testview1 setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), cyan)];
	[testview2 setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), yellow)];
    [testview3 setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), magenta)];
    [testview4 setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), orange)];
    [testview5 setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), white)];
*/	
	subviews = [[NSMutableArray alloc] init];
	[self addView:aView];

// _transitionView is used for handling transitions of the views only
// _barTransitionView is used to handle the button bars transitioning
	_transitionView = [ self createTransitionView ];
	_barTransitionView = [ self createBarTransitionView ];
	_buttonBar = [ self createButtonBar ];
	
	[ self addSubview: _transitionView ];
	[ self addSubview: _barTransitionView ];
	
	[ _transitionView transition:6 toView:[subviews objectAtIndex:0]];
	[ _barTransitionView transition:6 toView:_buttonBar ];			
	
		
 
	}
	return self;
}

- (UITransitionView *)createTransitionView {
		 UITransitionView *transitionView = [ [ UITransitionView alloc ] initWithFrame:CGRectMake(0,0,320,460)];
    return transitionView;
	}

- (UITransitionView *)createBarTransitionView {
		 UITransitionView *transitionBarView = [ [ UITransitionView alloc ] initWithFrame:CGRectMake(0.0f, 411.0f, 320.0f, 49.0f)];
   // Create empty(blank) view for to transition the button bar to
   		 blankView = [ [ UIView alloc ] initWithFrame:CGRectMake(0.0f, 411.0f, 320.0f, 49.0f)];

	 return transitionBarView;
	}


- (UIButtonBar *)createButtonBar {
    UIButtonBar *buttonBar;
    buttonBar = [ [ UIButtonBar alloc ] 
       initInView: self
       withFrame: CGRectMake(0.0f, 0.0f, 320.0f, 49.0f)
       withItemList: [ self buttonBarItems ] ];
    [buttonBar setDelegate:self];
    [buttonBar setBarStyle:1];
    [buttonBar setButtonBarTrackingMode: 2];

    int buttons[5] = { 1, 2, 3, 4, 5};
    [buttonBar registerButtonGroup:0 withButtons:buttons withCount: 5];
    [buttonBar showButtonGroup: 0 withDuration: 0.0f];
    int tag;

    for(tag = 1; tag < 5; tag++) {
        [ [ buttonBar viewWithTag:tag ] 
            setFrame:CGRectMake(2.0f + ((tag - 1) * 64.0f), 1.0f, 64.0f, 48.0f)
        ];
    }
    [ buttonBar showSelectionForButton: 1];

    return buttonBar;
}

- (NSArray *)buttonBarItems {
    return [ NSArray arrayWithObjects:
        [ NSDictionary dictionaryWithObjectsAndKeys:
          @"buttonBarItemTapped:", kUIButtonBarButtonAction,
          @"imageup.png", kUIButtonBarButtonInfo,
          @"imagedown.png", kUIButtonBarButtonSelectedInfo,
          [ NSNumber numberWithInt: 1], kUIButtonBarButtonTag,
            self, kUIButtonBarButtonTarget,
          @"Blue", kUIButtonBarButtonTitle,
          @"0", kUIButtonBarButtonType,
          nil 
        ],

        [ NSDictionary dictionaryWithObjectsAndKeys:
          @"buttonBarItemTapped:", kUIButtonBarButtonAction,
          @"imageup.png", kUIButtonBarButtonInfo,
          @"imagedown.png", kUIButtonBarButtonSelectedInfo,
          [ NSNumber numberWithInt: 2], kUIButtonBarButtonTag,
            self, kUIButtonBarButtonTarget,
          @"Silver", kUIButtonBarButtonTitle,
          @"0", kUIButtonBarButtonType,
          nil 
        ], 

          [ NSDictionary dictionaryWithObjectsAndKeys:
          @"buttonBarItemTapped:", kUIButtonBarButtonAction,
          @"imageup.png", kUIButtonBarButtonInfo,
          @"imagedown.png", kUIButtonBarButtonSelectedInfo,
          [ NSNumber numberWithInt: 3], kUIButtonBarButtonTag,
            self, kUIButtonBarButtonTarget,
          @"Red", kUIButtonBarButtonTitle,
          @"0", kUIButtonBarButtonType,
          nil
        ],
		
		[ NSDictionary dictionaryWithObjectsAndKeys:
          @"buttonBarItemTapped:", kUIButtonBarButtonAction,
          @"imageup.png", kUIButtonBarButtonInfo,
          @"imagedown.png", kUIButtonBarButtonSelectedInfo,
          [ NSNumber numberWithInt: 4], kUIButtonBarButtonTag,
            self, kUIButtonBarButtonTarget,
          @"Green", kUIButtonBarButtonTitle,
          @"0", kUIButtonBarButtonType,
          nil
        ],

        [ NSDictionary dictionaryWithObjectsAndKeys:
          @"buttonBarItemTapped:", kUIButtonBarButtonAction,
          @"imageup.png", kUIButtonBarButtonInfo,
          @"imagedown.png", kUIButtonBarButtonSelectedInfo,
          [ NSNumber numberWithInt: 5], kUIButtonBarButtonTag,
            self, kUIButtonBarButtonTarget,
          @"Settings", kUIButtonBarButtonTitle,
          @"0", kUIButtonBarButtonType,
          nil
        ], 

        nil
    ];
}

- (void)buttonBarItemTapped:(id) sender {
    int button = [ sender tag ] - 1;
   /* switch (button) {
        case 1:
		if (currentView == CB_1) { }
		else {
			[self testAnimation];
            [ _transitionView transition:0 toView:testview1 ];
		    currentView = CB_1;
			}
            break;
        case 2:
		if (currentView == CB_2) { }
		else {
			[self testAnimation];
			[ _transitionView transition:0 toView:testview2 ];
		    currentView = CB_2;
			}
             break;
        case 3:
		if (currentView ==CB_3) { }
		else {
			 [self testAnimation];
			 [ _transitionView transition:0 toView:testview3 ];
		    currentView = CB_3;
			}
             break;
        case 4:
		if (currentView == CB_4) { }
		else {
			[self testAnimation];
			 [ _transitionView transition:0 toView:testview4 ];
		    currentView = CB_4;
			}
             break;
		case 5:
		if (currentView == CB_5) { }
		else {
			[self testAnimation];
            [ _transitionView transition:0 toView:testview5 ];
		    currentView = CB_5;
			}
             break;
    }
	*/
	if (currentView != button)
	{
		[self testAnimation];
		[ _transitionView transition:0 toView:[subviews objectAtIndex:button] ];
		currentView = button;
	}
    
}


- (void)reloadButtonBar {
    [ _buttonBar removeFromSuperview ];
    [ _buttonBar release ];
    _buttonBar = [ self createButtonBar ];
}

		 		 		 		
// Gets a mouse down event in the rect, but you can use it to catch mouse event in any rect you want
- (void)mouseDown:(GSEvent *)event {
NSLog(@"%s", _cmd);
    
	CGPoint point = GSEventGetLocationInWindow(event);
	if (CGRectContainsPoint(rect, point)) {
	if (!barStatus) {
	[ _barTransitionView transition:3 fromView:blankView toView:_buttonBar];
	barStatus = 1;
	}
	else {
	[ _barTransitionView transition:5 fromView:_buttonBar toView:blankView ];
		barStatus = 0;
	}
	}
}


// Sample layerkit animation
-(void)testAnimation {
LKAnimation *animation = [LKTransition animation];
  [animation setType: @"oglFlip"];
  [animation setTimingFunction: [LKTimingFunction functionWithName: @"easeInEaseOut"]];
  [animation setFillMode: @"extended"];
  [animation setTransitionFlags: 3];
  [animation setDuration: 10];
  [animation setSpeed:0.35];
  [animation setSubtype: @"fromLeft"];
[[self _layer] addAnimation: animation forKey: 0];
}


-(UIView*)addView: (UIView*) view
{
	if( view ) [subviews addObject: view];
	return view;
}
@end //@implementation ButtonBarView


