#import "Encryption.h"
#include "math.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    
    NSString *strCopy = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    double length = [strCopy length];
    double sqrtValue = sqrt(length);
    int floorValue = floor(sqrtValue);
    int ceilValue = ceil(sqrtValue);
    int row = floorValue;
    int column = ceilValue;
    
    if (row != column) {
        if (row * row >= length) {
            column = row;
        } else if ((row * column < length) && (column * column >= length)) {
            row = column;
        }
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    int len = 0;
    
    while( (len + column) < length) {
        [array addObject:[strCopy substringWithRange:NSMakeRange(len, column)]];
        len += column;
    }
    [array addObject:[strCopy substringFromIndex:len]];
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    for (int i = 0; i < column; i++)
    {
        for (NSString *rowString in array) {
            if ([rowString length] >= i + 1) {
                [resultString appendString:[rowString substringWithRange:NSMakeRange(i, 1)]];
            }
        }
        [resultString appendString:@" "];
    }
    
    NSLog(@"result=%@", resultString);
    NSString *trimmedString = [resultString stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

@end
