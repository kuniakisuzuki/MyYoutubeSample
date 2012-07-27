//
//  MyViewController.m
//  MyYoutubeSample
//
//  Created by Suzuki Kuniaki on 2012/07/27.
//  Copyright (c) 2012年 Suzuki Kuniaki. All rights reserved.
//

#import "MyViewController.h"


@interface MyViewController (PrivateMethods)
   
@end

@implementation MyViewController


- (void)viewDidUnload
{
    _tableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    GDataServiceGoogleYouTube *service = [self youTubeService];
    
    NSURL *feedURL = [GDataServiceGoogleYouTube youTubeURLForFeedID:nil];
    
    GDataQueryYouTube *query = [GDataQueryYouTube youTubeQueryWithFeedURL:feedURL];
    [query setVideoQuery:@"GLAY"];
    
    [query setStartIndex:1];
    [query setMaxResults:5];
    [query setOrderBy:@"published"];
    
    GDataServiceTicket *ticket = [service fetchFeedWithQuery:query delegate:self
                       didFinishSelector:@selector(request:finishedWithFeed:error:)];
}


- (GDataServiceGoogleYouTube *)youTubeService {
    static GDataServiceGoogleYouTube* _service = nil;
    
    if (!_service) {
        _service = [[GDataServiceGoogleYouTube alloc] init];
        
        [_service setYouTubeDeveloperKey:@""];//set your Youtube developer key.
        
        //[_service setUserAgent:@"AppWhirl-UserApp-1.0"];
        //[_service setShouldCacheResponseData:YES];
        //[_service setServiceShouldFollowNextLinks:YES];
    }
    
    [_service setUserCredentialsWithUsername:nil
                                    password:nil];
    
    return _service;
}


#pragma mark - GDataServiceTicket delegate

- (void)request:(GDataServiceTicket *)ticket
finishedWithFeed:(GDataFeedBase *)aFeed
          error:(NSError *)error {
    
    feed = (GDataFeedYouTubeVideo *)aFeed;
    
    [_tableView reloadData];
}

    


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(feed == nil)
        return 0;
    
    return [[feed entries] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    
    
    GDataEntryBase *entry = [[feed entries] objectAtIndex:indexPath.row];
    
    NSString *title = [[entry title] stringValue];
    
    NSString *descriotion = [[[(GDataEntryYouTubeVideo *)entry mediaGroup] mediaDescription] contentStringValue];
    
    //NSArray *thumbnails = [[(GDataEntryYouTubeVideo *)entry mediaGroup] mediaThumbnails];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = descriotion;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
