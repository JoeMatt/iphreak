//
//  KeyPad.m
//  iPhreak
//
//  Created by Joseph Mattiello on 1/21/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//

#import "KeyPadView.h"
#import "Key.h" 
#import "iPhreakApp.h"
#import "TonePlayer.h" 

@implementation KeyPad

-(id)initWithDictionary:(NSDictionary*) aDict parent:(id)sender
{
	if(self = [super init])
	{	
		myDictionary = [[NSDictionary alloc] initWithDictionary:aDict]; 
		myName = [myDictionary valueForKey:@"Name"];
		parent = sender;
		activeTimer = nil;
		
		
		UIImage * background = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",myName,[myDictionary valueForKey:@"Background"]]];
			
		self.frame = CGRectMake(0,0,320,460);
		self.image = background;
		
		[self addButtons];	
	}
	return self; 
}

#define UIPushButton UIButton
-(void)addButtons
{ 
	
	/*For each Key in Keys, make key
	 *-(id)initWithFirstFrequency: (int) aFreq secondFrequency: (int) anotherFreq defaultImage: (UIImage*) aImage pressedImage: (UIImage*) anotherImage;
	 * //key names, DefaultImage, Osc1, Osc2, PressedImage, Xpos, Ypos
	 */
	
	NSDictionary * keysDict = [myDictionary objectForKey:@"Keys"];
	NSEnumerator *enumerator = [keysDict objectEnumerator];
	NSDictionary * key;
	UIPushButton * pushButton;
	int x=0;
	
	while ((key = [enumerator nextObject])) {
		NSNumber*         aNSNumber;
		unsigned osc1, osc2, xPos, yPos;
		
		aNSNumber = [key valueForKey:@"Osc1"];
		osc1 = [aNSNumber unsignedIntValue];
		
		aNSNumber = [key valueForKey:@"Osc2"];
		osc2 = [aNSNumber unsignedIntValue];
		
		aNSNumber = [key valueForKey:@"Xpos"];
		xPos = [aNSNumber unsignedIntValue];
		
		aNSNumber = [key valueForKey:@"Ypos"];
		yPos = [aNSNumber unsignedIntValue];
		
		[aNSNumber release];

		/* code that uses the returned key */
		keys[x]= [[Key alloc] initWithFirstFrequency:osc1 
									 secondFrequency:osc2 
									defaultImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",myName,[key valueForKey:@"DefaultImage"]]] 
										pressedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",myName,[key valueForKey:@"PressedImage"]]] 
												xPos:xPos 
												yPos:yPos
											  keyPad:self];
		
		pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[pushButton setFrame: CGRectMake([keys[x] xPos] , [keys[x] yPos], 100.0, 50.0)];
			[pushButton setEnabled:YES];  //may not be needed	

		pushButton.contentMode = UIViewContentModeScaleAspectFill;
			
		[pushButton setImage:[keys[x] defaultImage] forState:0];  //up state
		[pushButton setImage:[keys[x] pressedImage] forState:1]; //down state	
		[pushButton addTarget:keys[x] action: @selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];

		[self addSubview: pushButton];
		
		DLog(@"Added key: osc1:%i osc2:%i Xpos:%i Ypos:%i Image:%@ Pressed:%@",osc1, osc2, [keys[x] xPos], [keys[x] yPos], [NSString stringWithFormat:@"%@/%@",myName,[key valueForKey:@"DefaultImage"]], [NSString stringWithFormat:@"%@/%@",myName,[key valueForKey:@"PressedImage"]]);
		x++;
	}
	numKeys = x+1;	
	
	// The result text is just 89 pixels at the top.
	// hardcoded for now.
	struct CGRect frame = [[UIScreen mainScreen] applicationFrame];
	frame.origin.x = frame.origin.y = 0.0f;
	
	struct CGRect resultRect = frame;
	resultRect.size.height = 89.0f;
	NSLog(@"resultRect is %f, %f, %f, %f", resultRect.origin.x, resultRect.origin.y, resultRect.size.width, resultRect.size.height);
	
	// result text field up there at the top -- like a normal calculator
	UITextView* resultDisplay = [[UITextView alloc] initWithFrame: resultRect];
	[resultDisplay setEditable: NO];
	[resultDisplay setScrollEnabled: NO];
	//[resultText setTextSize: 64];
	
	//[resultDisplay setHTML:@"<span style=\"color:#124564;text-align:right;display:block;font-family:helvetica;font-size:64px;font-weight:normal;width:100%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;letter-spacing:-2px;\">blah</span>"];
	//[resultDisplay setNeedsDisplay];
	//[view addSubview: resultDisplay];
}	

-(void)keyPressed: (Key*)aKey;
{ 
	Key * key = aKey;
	iPhreakAppDelegate * appDelegate = (iPhreakAppDelegate*) parent;
	
	DLog(@"Button %i %i pressed",[key freq1], [key freq2] );
	NSTimeInterval interval = .16;
	
	[[appDelegate getToneByIndex:0] setFrequency:[key freq1]];
	[[appDelegate getToneByIndex:1] setFrequency:[key freq2]];
//	[[appDelegate player] play];

	if( activeTimer != nil && [activeTimer isValid] == YES )
	{
		[activeTimer invalidate];
		//[activeTimer release];
		//activeTimer = nil;
	}
	
	activeTimer = [[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(resetTones:) userInfo:self repeats:NO] retain]; //if you don't retain, isValid will segfault above

}

-(void)resetTones:(NSTimer*)theTimer
{
	iPhreakAppDelegate * app = (iPhreakAppDelegate*) parent;
	[[app getToneByIndex:0] setFrequency:0];
	[[app getToneByIndex:1] setFrequency:0];
}

@end
