//
//  MainViewController.m
//  RSSchool_T4
//
//  Created by Hanna Rybakova on 4/21/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    self.phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 100.f, 40.f)];
    self.phoneNumber.center = CGPointMake(self.view.center.x, self.view.bounds.size.height / 4);
    self.phoneNumber.layer.borderColor = [UIColor grayColor].CGColor;
    self.phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneNumber.keyboardType = UIKeyboardTypePhonePad;
    [self setEmptyLeftView];
    self.phoneNumber.leftViewMode=UITextFieldViewModeAlways;
    self.phoneNumber.delegate = self;
    self.phoneNumber.textContentType = UITextContentTypeTelephoneNumber;
    [self.view addSubview:self.phoneNumber];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string length] == 0)
        return YES;
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"] invertedSet];
    if ([string rangeOfCharacterFromSet:set].location != NSNotFound) {
        return NO;
    }
    
    //allow to enter + only once
    if ((textField.text.length != 0) && ([string isEqualToString: @"+"])) {
        return NO;
    }
    
    NSMutableString *currentString = [NSMutableString stringWithString:textField.text];
    [currentString replaceCharactersInRange:range withString:string];
    NSString *cleanedString = [[currentString componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    
    if (cleanedString.length > 12) {
        return NO;
    }
    //determine validation type
    if (cleanedString.length >= 2) {
        NSArray *resultArray = [self getPhoneNumberParameters:cleanedString];
        if (resultArray.count > 0) {
            [self setLeftImage:resultArray[0]];
            [self setFormat:cleanedString lenght:([resultArray[1] integerValue])];
            return NO;
        } else {
            [self setEmptyLeftView];
            [self setFormat:cleanedString lenght:12];
            return NO;
        }
    } else {
        [self setEmptyLeftView];
    }
    
    //add plus in any case
    if (cleanedString.length > 0) {
        if (![[currentString substringToIndex:1] isEqualToString:@"+"]) {
            self.phoneNumber.text = [NSMutableString stringWithFormat:@"+%@", currentString];
            return NO;
        }
    }
    return YES;
}

- (void)setFormat:(NSString *)string lenght:(NSInteger)type {
    NSString *tempString = [[NSMutableString alloc] initWithString:string];
    NSString *newTemp = [tempString stringByPaddingToLength: 12 withString: @"*" startingAtIndex:0];
    switch (type) {
        case 8:
            //+XXX (xx) xxx-xxx
            tempString = [NSString stringWithFormat:@"+%C%C%C (%C%C) %C%C%C-%C%C%C",
                          [newTemp characterAtIndex:0],
                          [newTemp characterAtIndex:1],
                          [newTemp characterAtIndex:2],
                          [newTemp characterAtIndex:3],
                          [newTemp characterAtIndex:4],
                          [newTemp characterAtIndex:5],
                          [newTemp characterAtIndex:6],
                          [newTemp characterAtIndex:7],
                          [newTemp characterAtIndex:8],
                          [newTemp characterAtIndex:9],
                          [newTemp characterAtIndex:10]
                          ] ;
            break;
        case 9:
            //+XXX (xx) xxx-xx-xx
            tempString = [NSString stringWithFormat:@"+%C%C%C (%C%C) %C%C%C-%C%C-%C%C",
                          [newTemp characterAtIndex:0],
                          [newTemp characterAtIndex:1],
                          [newTemp characterAtIndex:2],
                          [newTemp characterAtIndex:3],
                          [newTemp characterAtIndex:4],
                          [newTemp characterAtIndex:5],
                          [newTemp characterAtIndex:6],
                          [newTemp characterAtIndex:7],
                          [newTemp characterAtIndex:8],
                          [newTemp characterAtIndex:9],
                          [newTemp characterAtIndex:10],
                          [newTemp characterAtIndex:11]
                          ] ;
            break;
        case 10:
            //+XX (xxx) xxx xx xx
            tempString = [NSString stringWithFormat:@"+%C%C (%C%C%C) %C%C%C-%C%C-%C%C",
                          [newTemp characterAtIndex:0],
                          [newTemp characterAtIndex:1],
                          [newTemp characterAtIndex:2],
                          [newTemp characterAtIndex:3],
                          [newTemp characterAtIndex:4],
                          [newTemp characterAtIndex:5],
                          [newTemp characterAtIndex:6],
                          [newTemp characterAtIndex:7],
                          [newTemp characterAtIndex:8],
                          [newTemp characterAtIndex:9],
                          [newTemp characterAtIndex:10],
                          [newTemp characterAtIndex:11]
                          ] ;
            break;
        default:
            //+XXXXXXXXXXXX
            tempString = [NSString stringWithFormat:@"+%C%C%C%C%C%C%C%C%C%C%C%C",
                          [newTemp characterAtIndex:0],
                          [newTemp characterAtIndex:1],
                          [newTemp characterAtIndex:2],
                          [newTemp characterAtIndex:3],
                          [newTemp characterAtIndex:4],
                          [newTemp characterAtIndex:5],
                          [newTemp characterAtIndex:6],
                          [newTemp characterAtIndex:7],
                          [newTemp characterAtIndex:8],
                          [newTemp characterAtIndex:9],
                          [newTemp characterAtIndex:10],
                          [newTemp characterAtIndex:11]
                          ] ;
            break;
    }
    NSMutableString *resultStr = [tempString mutableCopy];
    [resultStr replaceOccurrencesOfString:@"*" withString:@"_" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [resultStr length])];
    
    self.phoneNumber.text = resultStr;
    [resultStr release];
}

- (void)setLeftImage:(NSString *)imageName {
    UIImageView *imgforLeft=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.phoneNumber.frame.size.height/1.3f, self.phoneNumber.frame.size.height/1.3f)];
    [imgforLeft setImage:[UIImage imageNamed:[NSMutableString stringWithFormat:@"%@.png", imageName]]];
    [imgforLeft setContentMode:UIViewContentModeScaleAspectFit];
    [self.phoneNumber setLeftView:imgforLeft];
    [imgforLeft release];
}

- (void)setEmptyLeftView {
    UIView *imgforLeft=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.phoneNumber.frame.size.height/1.3f, self.phoneNumber.frame.size.height/1.3f)];
    self.phoneNumber.leftView = imgforLeft;
    [imgforLeft release];
}

- (NSArray *)getPhoneNumberParameters:(NSString *)inputString {
    NSArray *array = [NSArray new];
    
    NSDictionary* flagsDict = @{
                                      @"70": @[@"flag_RU", @10],
                                      @"71": @[@"flag_RU", @10],
                                      @"72": @[@"flag_RU", @10],
                                      @"73": @[@"flag_RU", @10],
                                      @"74": @[@"flag_RU", @10],
                                      @"75": @[@"flag_RU", @10],
                                      @"76": @[@"flag_RU", @10],
                                      @"77": @[@"flag_KZ", @10],
                                      @"78": @[@"flag_RU", @10],
                                      @"79": @[@"flag_RU", @10],
                                      @"373": @[@"flag_MD", @8],
                                      @"374": @[@"flag_AM", @8],
                                      @"375": @[@"flag_BY", @9],
                                      @"380": @[@"flag_UA", @9],
                                      @"992": @[@"flag_TJ", @9],
                                      @"993": @[@"flag_TM", @8],
                                      @"994": @[@"flag_AZ", @9],
                                      @"396": @[@"flag_KG", @9],
                                      @"998": @[@"flag_UZ", @9]
                                };
    
    NSString *temp = [NSMutableString new];
    temp = [inputString substringToIndex:2];
    id object = [flagsDict valueForKey:temp];
    if (object != nil) {
        //found
        array = (NSArray *)object;
    } else {
        //not found
        if (inputString.length > 2) {
            temp = [inputString substringToIndex:3];
            object = [flagsDict valueForKey:temp];
            if (object != nil) {
                //found
                array = (NSArray *)object;
            }
        }
    }
    [temp release];
    return array;
}

@end
