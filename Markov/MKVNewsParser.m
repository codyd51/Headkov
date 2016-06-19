//
//  MKVNewsParser.m
//  Markov
//
//  Created by Phillip Tennen on 6/16/16.
//  Copyright © 2016 Phillip Tennen. All rights reserved.
//

#import "MKVNewsParser.h"

@implementation MKVNewsParser
-(instancetype)initWithFeedURL:(NSURL*)url {
    if ((self = [super init])) {
        _parser = [[MWFeedParser alloc] initWithFeedURL:url];
        _parser.delegate = self;
        _parser.feedParseType = ParseTypeFull;
        _parser.connectionType = ConnectionTypeSynchronously;
        
        _headlines = [NSMutableArray new];
    }
    return self;
}
-(void)parseStart {
    [_parser parse];
}
-(void)refreshWithCompletion:(void(^__strong)(NSArray *))compBlock {
    _compBlock = compBlock;
    [self parseStart];
}
-(void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    //NSLog(@"%@: %@, %@", info.link, info.title, info.summary);
}
-(void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    /*
    static int i = 0;
    NSLog(@"---%i--", i);
    
    NSLog(@"%@ - %@: %@ by %@", item.date, item.link, item.title, item.author);
    NSLog(@"%@", item.summary);
    NSLog(@"%@", item.content);
    NSLog(@"Identifier: %@", item.identifier);
    i++;
     */
    [_headlines addObject:item.title];
}
-(void)feedParserDidFinish:(MWFeedParser *)parser {
    _compBlock(_headlines);
}
@end
