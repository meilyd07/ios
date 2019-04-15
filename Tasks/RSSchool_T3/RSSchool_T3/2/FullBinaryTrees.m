#import "FullBinaryTrees.h"
#import "ArrayPrintBinary.h"
// good luck

@implementation FullBinaryTrees : NSObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _resultDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_resultDictionary release];
    [super dealloc];
}

- (NSString *)stringForNodeCount:(NSInteger)count {
    
    [self allPossibleFBT:count];
    
    NSArray *temp = [[NSArray alloc] initWithArray:[self.resultDictionary objectForKey: @(count).stringValue]];
    
    return [temp printBinary];
}

- (NSMutableArray *)allPossibleFBT:(NSInteger)countNodes {
    
    if (![self.resultDictionary objectForKey:@(countNodes).stringValue]) {
        NSMutableArray *possible = [[NSMutableArray alloc] init];
        if (countNodes == 1) {
            NSMutableArray *treeNode = [[NSMutableArray alloc] init];
            [treeNode addObject:@0];
            [treeNode addObject:[NSNull null]];//left
            [treeNode addObject:[NSNull null]];//right
            
            [possible addObject:treeNode];
        } else if (countNodes % 2 == 1){
            for (int x = 0; x < countNodes; ++x) {
                int y = countNodes - 1 - x;
                
                NSMutableArray *left = [self allPossibleFBT:x];
                NSMutableArray *right = [self allPossibleFBT:y];
                
                for (NSMutableArray* l in left) {
                    for (NSMutableArray* r in right) {
                        NSMutableArray *node = [[NSMutableArray alloc] init];
                        [node addObject:@0];
                        [node addObject:[NSNull null]];//left
                        [node addObject:[NSNull null]];//right
                        node[1] = l;
                        node[2] = r;
                        [possible addObject:node];
                    }
                }
                //[possible addObject:@"pppp"];
            }
        }
        [self.resultDictionary setObject:possible forKey:@(countNodes).stringValue];
    }
    
    
    return [self.resultDictionary valueForKey:@(countNodes).stringValue];
}
@end
