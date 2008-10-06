//
//  KeyPad.h
//  iPhreak
//
//  Created by Joseph Mattiello on 1/21/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Key;

@interface KeyPad : UIImageView {
	unsigned numRows, 
			 numCols, 
			 numKeys;
	
	Key * keys[16];
	NSDictionary* myDictionary;
	NSString * myName;
	id parent;
	NSTimer * activeTimer;
}

-(id)initWithDictionary:(NSDictionary*) aDict parent:(id) sender;

-(void)keyPressed: (Key*)aKey;
-(void)resetTones:(NSTimer*)theTimer;
-(void)addButtons;
@end
