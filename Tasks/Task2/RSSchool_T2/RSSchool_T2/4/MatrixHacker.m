#import "MatrixHacker.h"

@implementation MatrixHacker
{
    id<Character> (^_theBlock)(NSString *name);
}
// your code here
//You need to implement a method injectCode: which would take a block and peersist it.

//Later, when runCodeWithData: is called, the class should apply the saved block to each
//element of the array, creating either a character with the same name either a clone
//named "Agent Smith". If the name is not "Neo", the clone of "Agent Smith" is created.

- (void)dealloc {
    [_theBlock release];
    [super dealloc];
}

- (void)injectCode:(id<Character> (^)(NSString *name))theBlock {
    _theBlock = [theBlock copy];
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
    
    NSMutableArray<id<Character>> *array = [[NSMutableArray<id<Character>> alloc] init];
    
    for (NSString *name in names)
    {
        id<Character> ch = _theBlock(name);
        
        if ([ch.class respondsToSelector:@selector(createWithName:isClone:)]) {

            if ([name isEqualToString:@"Neo"])
            {
                ch = [[ch class] createWithName:name isClone:NO];
            } else {
                ch = [[ch class] createWithName:name isClone:YES];
            }
            [array addObject:ch];
        }
    }
    NSArray<id<Character>> *unmmutableCopy = [array copy];
    [array release];
    return [unmmutableCopy autorelease];
}
@end
