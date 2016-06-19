//
//  MKVNewsParser.h
//  Markov
//
//  Created by Phillip Tennen on 6/16/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedParser.h"

@interface MKVNewsParser : NSObject <MWFeedParserDelegate> {
    MWFeedParser* _parser;
    void (^_compBlock)(NSArray* titles);
    NSMutableArray* _headlines;
}
-(instancetype)initWithFeedURL:(NSURL*)url;
-(void)refreshWithCompletion:(void(^__strong)(NSArray* titles))compBlock;
@end
