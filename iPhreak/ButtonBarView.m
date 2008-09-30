/*
 * From Drunknbass: http://idevdocs.com/forum/showthread.php?t=147
 *
 *
 * project setup by Cobra
 * added window and app support
 */

#import "ButtonBarView.h"

@implementation ButtonBarView

-(id)initWithFrame:(CGRect)frame andView: (UIView *) aView
{
	if ((self == [super initWithFrame:frame])!=nil) {
	
	barStatus = 1;

	rect = frame;
	_offScreenRect = frame;
	_onScreenRect = frame;
	_onScreenRect.origin.x = 0.0f;
	rect.origin.x = rect.origin.y = 0.0f;
		
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


- (UITabBar *)createButtonBar {
    UITabBar *buttonBar;
    buttonBar = [ [ UITabBar alloc ] 
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
//NSLog(@"%s", _cmd);
    
	CGPoint point = GSEventGetLocationInWindow(event);
	if (CGRectContainsPoint(rect, point)) {
	if (!barStatus) {
	[ _barTransitionView transition:3 fromView:blankView toView:_buttonBar];
	barStatus = 1;
	}
		//TODO : Temporary uncomenting to disable auto-hide. Will later add options for auto-hiding
/*	else {
	[ _barTransitionView transition:5 fromView:_buttonBar toView:blankView ];
		barStatus = 0;
	} */
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


