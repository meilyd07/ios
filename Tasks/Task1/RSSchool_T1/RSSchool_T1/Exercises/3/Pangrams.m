#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    NSArray *letters = [@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "];
    NSString *uppercaseCopy = [string uppercaseString];
    
    for (NSString *str in letters) {
        if ([uppercaseCopy rangeOfString:str].location == NSNotFound) {
            return NO;
        }
    }
    return YES;
}

@end
