//
//  Key.m
//  iPhreak
//
//  Created by Joseph Mattiello on 1/21/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//

#import "Key.h"
#import "KeyPadView.h"

@implementation Key


-(void)setFirstFrequency: (int) aFreq
{
	freq1 = aFreq;
}

-(void)setSecondFrequency: (int) aFreq
{
	freq2 = aFreq;
}

-(void)setDefaultImage: (UIImage*) image
{
	defaultImage = image;
}

-(void)setPressedImage: (UIImage*) image
{
	pressedImage = image;
}

-(void)setKeyPad: (KeyPad*) aKeyPad
{
	parentPad = aKeyPad;
}

-(void)buttonPressed
{
	[parentPad keyPressed:self];
}



-(UIImage*)defaultImage
{ return defaultImage; }

-(UIImage*)pressedImage
{ return pressedImage; }

-(unsigned)xPos
{ return xPos; }

-(unsigned)freq1
{ return freq1; }

-(unsigned)yPos
{ return yPos; }

-(unsigned)freq2
{ return freq2; }

-(id)initWithFirstFrequency: (int) aFreq secondFrequency: (int) anotherFreq defaultImage: (UIImage*) aImage pressedImage: (UIImage*) anotherImage xPos:(int) aXPos yPos:(int) aYPos keyPad:(KeyPad*) aKeyPad
{
	[super init];
	[self setFirstFrequency:aFreq];
	[self setSecondFrequency:anotherFreq];
	[self setDefaultImage:aImage];
	[self setPressedImage:anotherImage];
	[self setKeyPad:aKeyPad];
	xPos = aXPos;
	yPos = aYPos;
}

@end
 