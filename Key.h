//
//  Key.h
//  iPhreak
//
//  Created by Joseph Mattiello on 1/21/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

@class KeyPad;

@interface Key : NSObject {
	UIImage * defaultImage;
	UIImage * pressedImage;
	unsigned freq1, freq2, xPos, yPos;
	KeyPad * parentPad;
}

-(void)setFirstFrequency: (int) aFreq;
-(void)setSecondFrequency: (int) aFreq;
-(void)setDefaultImage: (UIImage*) image;
-(void)setPressedImage: (UIImage *) image;
-(void)setKeyPad: (KeyPad*) aKeyPad;


-(id)initWithFirstFrequency: (int) aFreq secondFrequency: (int) anotherFreq defaultImage: (UIImage*) aImage pressedImage: (UIImage*) anotherImage xPos:(int) aXPos yPos:(int) aYPos keyPad:(KeyPad*) aKeyPad ;

-(UIImage*)defaultImage;
-(UIImage*)pressedImage;
-(unsigned)xPos;
-(unsigned)yPos;
-(unsigned)freq1;
-(unsigned)freq2;


-(void)buttonPressed;


@end
