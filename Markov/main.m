//
//  main.m
//  Markov
//
//  Created by Phillip Tennen on 6/14/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKVStringGenerator.h"
#import "MKVNewsParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //get input from stdin
        /*
        input = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        input = [input stringByTrimmingCharactersInSet:[NSCharacterSet illegalCharacterSet]];
        
        //generate text from input
        MKVStringGenerator* gen = [[MKVStringGenerator alloc] initWithBaseString:input];
        NSString* res = [gengenerateString:500];
        NSLog(@"%@", res);
         */
        MKVNewsParser* parser = [[MKVNewsParser alloc] initWithFeedURL:[NSURL URLWithString:@"http://rss.cnn.com/rss/cnn_topstories.rss"]];
        [parser refresh];
    }
    return 0;
}
