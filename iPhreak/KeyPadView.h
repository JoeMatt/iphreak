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

@interface KeyPad : UIView {
	UIImage * background;
	unsigned numRows, 
			 numCols, 
			 numKeys;
	
	Key * keys[16];
	NSDictionary* myDictionary;
	UIImageView * view;
	NSString * myName;
	id parent;
	NSTimer * activeTimer;
}

-(void)keyPressed: (Key*)aKey;
-(void)resetTones:(NSTimer*)theTimer;
-(void)makeKeys: (id) sender;
-(void)makeView: (id) sender;
-(UIView*)getView;
-(id)initWithDictionary:(NSDictionary*) aDict parent:(id) sender;
@end
