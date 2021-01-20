//
//  ViewControllerUserSaveModel.m
//  TEXT
//
//  Created by 刘博 on 2020/12/19.
//  Copyright © 2020 刘博. All rights reserved.
//

#import "ViewControllerUserSaveModel.h"
#import "PersonModel.h"

@interface ViewControllerUserSaveModel ()

@end

@implementation ViewControllerUserSaveModel

- (void)viewDidLoad {
    [super viewDidLoad];
    PersonModel *person = [[PersonModel alloc] init];
    person.name = @"你好你好";
    person.gender = @"nv";
    NSData * personData  = [NSKeyedArchiver archivedDataWithRootObject:person];
    [[NSUserDefaults standardUserDefaults] setObject:personData forKey:@"kkk"];
    NSData *tmpData = [[NSUserDefaults standardUserDefaults] objectForKey:@"kkk"];
    PersonModel *tmpPerson = [NSKeyedUnarchiver unarchiveObjectWithData:tmpData];
    NSLog(@"名字名字名字%@",tmpPerson.name);
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
