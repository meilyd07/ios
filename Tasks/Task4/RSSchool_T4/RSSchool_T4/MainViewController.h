//
//  MainViewController.h
//  RSSchool_T4
//
//  Created by Hanna Rybakova on 4/21/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField* phoneNumber;
@end
