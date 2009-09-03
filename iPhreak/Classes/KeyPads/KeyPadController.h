//
//  KeyPadController.h
//  iPhreak
//
//  Created by Joseph Mattiello on 9/29/08.
//  Copyright 2008 Joe Mattiello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../KeyPadView.h"

@interface KeyPadController : UIViewController {
	NSDictionary * boxDictionary;
}
@property (nonatomic, retain) NSDictionary * boxDictionary;
@end
