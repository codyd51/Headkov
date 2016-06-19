//
//  MKVStringGenerator.h
//  Markov
//
//  Created by Phillip Tennen on 6/16/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKVStringGenerator : NSObject {
    NSMutableDictionary* _states;
}
@property (nonatomic, retain) NSArray* tokens;
-(instancetype)initWithBaseString:(NSString*)string;
-(NSString*)generateStringOfLength:(int)wordCount;
@end
