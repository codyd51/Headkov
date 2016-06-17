//
//  main.m
//  Markov
//
//  Created by Phillip Tennen on 6/14/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKVStringGenerator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //get input from stdin
        NSFileHandle* stdinHandle = [NSFileHandle fileHandleWithStandardInput];
        NSString *input = [[NSString alloc] initWithData:[NSData dataWithData:[stdinHandle availableData]] encoding:NSUTF8StringEncoding];
        input = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        input = [input stringByTrimmingCharactersInSet:[NSCharacterSet illegalCharacterSet]];
        
        //generate text from input
        MKVStringGenerator* gen = [[MKVStringGenerator alloc] initWithBaseString:input];
        NSString* res = [gen generateString:500];
        NSLog(@"%@", res);
    }
    return 0;
}
