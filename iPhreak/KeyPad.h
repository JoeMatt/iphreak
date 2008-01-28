//
//  KeyPad.h
//  iPhreak
//
//  Created by Joseph Mattiello on 1/21/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <GraphicsServices/GraphicsServices.h>
#import <LayerKit/LayerKit.h>
#import <UIKit/UIKit.h>
#import "Key.h" 

@interface KeyPad : NSObject {
	UIImage * background;
	unsigned numRows, numCols, numKeys;
	Key * keys[16];
	//NSArray* buttonLocations;
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
