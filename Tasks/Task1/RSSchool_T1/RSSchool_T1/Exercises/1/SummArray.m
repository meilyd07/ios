#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    
    int sum = 0;
    for (NSNumber * n in array) {
        sum += [n integerValue];
    }
    return [NSNumber numberWithInt:sum];
}

@end
