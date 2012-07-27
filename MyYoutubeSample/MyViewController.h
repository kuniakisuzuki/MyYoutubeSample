//
//  MyViewController.h
//  MyYoutubeSample
//
//  Created by Suzuki Kuniaki on 2012/07/27.
//  Copyright (c) 2012年 Suzuki Kuniaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GData.h"

@interface MyViewController : UIViewController
{
    
    
    __weak IBOutlet UITableView *_tableView;
    GDataFeedYouTubeVideo *feed;
}
@end
