#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    
    int secondDiagonalSum = 0;
    int firstDiagonalSum = 0;
    int firstDiagonalPosition = 0;
    int secondDiagonalPosition = [array count] - 1;
    
    for (NSString *str in array) {
        NSArray *lineArray = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        firstDiagonalSum += [lineArray[firstDiagonalPosition] integerValue];
        firstDiagonalPosition += 1;
        
        secondDiagonalSum += [lineArray[secondDiagonalPosition] integerValue];
        secondDiagonalPosition -= 1;
    }
    return @(abs(secondDiagonalSum - firstDiagonalSum));
}

@end
