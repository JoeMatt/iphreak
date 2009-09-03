//
//  KeyPadController.m
//  iPhreak
//
//  Created by Joseph Mattiello on 9/29/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//

#import "KeyPadController.h"


@implementation KeyPadController
@synthesize boxDictionary;
/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
-(id)initWithDictionary:(NSDictionary*) aDict parent:(id)sender;
{
	self = [super init];
	if (self != nil) {
		self.boxDictionary = aDict;
	}
	return self;
}



// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
	KeyPad * keyPad = [[KeyPad alloc] initWithDictionary:self.boxDictionary parent:self];
	self.view = keyPad;
	[keyPad release];
}


/*
// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
