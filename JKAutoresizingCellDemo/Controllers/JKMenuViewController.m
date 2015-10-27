//
//  JKMenuViewController.m
//  JKAutoresizingCellDemo
//
//  Created by Jack Huang on 15/10/17.
//  Copyright © 2015年 Jack's app for practice. All rights reserved.
//

#import "JKMenuViewController.h"
#import "JKEntity.h"
#import "JKAutoresizingTableViewController.h"

@interface JKMenuViewController ()
@property (nonatomic, strong) NSArray *entities;
@end

@implementation JKMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    [self loadEntities];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [self pushCodeDemo];
            break;
        case 1:
            [self pushViewDemo];
            break;
    }
}

- (void)pushCodeDemo
{
    JKAutoresizingTableViewController *tvc = [[JKAutoresizingTableViewController alloc] init];
    tvc.entities = self.entities;
    [self.navigationController pushViewController:tvc animated:YES];
}

- (void)pushViewDemo
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadEntities
{
    NSUInteger count = 20;
    NSMutableArray *entities = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < count; i++) {
        JKEntity *entity = [[JKEntity alloc] init];
        entity.title = [self isNonNull] ? @"Entity" : nil;
        entity.content = [self isNonNull] ? [self randomText] : nil;
        entity.hasImage = [self isNonNull];
        entity.hasAudio = [self isNonNull];
        [entities addObject:entity];
    }
    
    self.entities = [entities copy];
}

- (BOOL)isNonNull
{
    return arc4random() % 2 > 0;
}

- (NSString *)randomText
{
    NSString *rawContent = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida, felis orci dictum risus, sed sodales sem eros eget risus. Morbi imperdiet sed diam et sodales. Vestibulum ut est id mauris ultrices gravida. Nulla malesuada metus ut erat malesuada, vitae ornare neque semper. Aenean a commodo justo, vel placerat odio. Curabitur vitae consequat tortor. Aenean eu magna ante. Integer tristique elit ac augue laoreet, eget pulvinar lacus dictum. Cras eleifend lacus eget pharetra elementum. Etiam fermentum eu felis eu tristique. Integer eu purus vitae turpis blandit consectetur. Nulla facilisi. Praesent bibendum massa eu metus pulvinar, quis tristique nunc commodo. Ut varius aliquam elit, a tincidunt elit aliquam non. Nunc ac leo purus. Proin condimentum placerat ligula, at tristique neque scelerisque ut. Suspendisse ut congue enim. Integer id sem nisl. Nam dignissim, lectus et dictum sollicitudin, libero augue ullamcorper justo, nec consectetur dolor arcu sed justo. Proin rutrum pharetra lectus, vel gravida ante venenatis sed. Mauris lacinia urna vehicula felis aliquet venenatis. Suspendisse non pretium sapien. Proin id dolor ultricies, dictum augue non, euismod ante. Vivamus et luctus augue, a luctus mi. Maecenas sit amet felis in magna vestibulum viverra vel ut est. Suspendisse potenti. Morbi nec odio pretium lacus laoreet volutpat sit amet at ipsum. Etiam pretium purus vitae tortor auctor, quis cursus metus vehicula. Integer ultricies facilisis arcu, non congue orci pharetra quis. Vivamus pulvinar ligula neque, et vehicula ipsum euismod quis.";
    
    static NSArray *components = nil;
    if (!components) {
        components = [rawContent componentsSeparatedByString:@" "];
    }
    
    NSInteger num = arc4random_uniform(components.count/3);
    num = MAX(5, num);
    
    NSArray *subComponents = [components objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, num)]];
    
    return [NSString stringWithFormat:@"%@ (End)", [subComponents componentsJoinedByString:@" "]];
}

@end
