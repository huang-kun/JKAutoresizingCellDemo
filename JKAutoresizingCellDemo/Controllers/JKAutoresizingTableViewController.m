//
//  JKAutoresizingTableViewController.m
//  JKAutoresizingCellDemo
//
//  Created by Jack Huang on 15/10/17.
//  Copyright © 2015年 Jack's app for practice. All rights reserved.
//

#import "JKAutoresizingTableViewController.h"
#import "JKEntityCell.h"
#import "JKEntity.h"

@interface JKAutoresizingTableViewController ()

@end

@implementation JKAutoresizingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 注册cell
    [self.tableView registerClass:[JKEntityCell class] forCellReuseIdentifier:@"JKEntityCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 重用cell，没有就创建一个
    JKEntityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JKEntityCell" forIndexPath:indexPath];
    
    // 填充cell的展示内容
    [self configureCell:cell forIndexPath:indexPath];
    
    // 确保约束已经添加到了cell中，因为这个cell可能是刚刚创建出来。
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];

//    cell.contentView.bounds = CGRectMake(0.0f, 0.0f, 9999, 9998.5);
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger i = 0;
    ++i;
    NSLog(@"calculate height %@ times.", @(i));
    
    // 创建一个cell用于计算高度
    static JKEntityCell *cell = nil;
    if (!cell) {
        // 注意这里必须创建而不是使用dequeueReusableCellWithIdentifier:来获得cell
        // 否则会因为创建出的cell没有返回到tableView:cellForItemAtIndexPath:中而造成内存泄漏。
        cell = [[JKEntityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JKEntityCell"];
    }
    
    // 如果一个cell有注册了重用ID，那么在dequeueReusableCellWithIdentifier:返回cell之前会调用prepareForReuse
    // 允许子类cell重载prepareForReuse
    [cell prepareForReuse];
    
    // 填充cell的展示内容
    [self configureCell:cell forIndexPath:indexPath];
    
    // 确保约束已经添加到了cell中，因为这个cell可能是刚刚创建出来。
    [cell setNeedsUpdateConstraints];
    // 子类cell重载的updateConstraints会被调用
    [cell updateConstraintsIfNeeded];
    
    // cell的宽度必须设为在tableView中的最终展示的宽度，因为只有确定宽度，才可以为多行文字的Label计算出准确高度
    // 无需在-[tableView:cellForRowAtIndexPath:]中设置它，因为cell在tableView中展示的时候会自动发生的
    // 假如需要展示section index列表或者group style，那么需要将cell的宽度小于tableView的宽度
    cell.contentView.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight);
    
    // 将layout传递给cell，这样布局引擎会根据约束计算出所有views的frame
    [cell setNeedsLayout];
    // 子类cell重载的layoutSubviews会被调用，而需要多行展示的label.preferredMaxLayoutWidth可以在那里设置
    [cell layoutIfNeeded];
    
//    NSLayoutConstraint *tempWidthLC =
//    [NSLayoutConstraint constraintWithItem:cell.contentView
//                                 attribute:NSLayoutAttributeWidth
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:nil
//                                 attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1
//                                  constant:CGRectGetWidth(tableView.frame)];
//
//    [cell.contentView addConstraint:tempWidthLC];

    // 通过这个方法得到计算后的最小size
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

//    [cell.contentView removeConstraint:tempWidthLC];
    
    // 给cell的分割线留出一个单位的高度，而分割线会加入在cell.contentView的底部到cell的底部之间
    if (tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
        cellSize.height += 1.0;
    }
    
    // 返回一个高度，强烈建议缓存结果！不然在iOS 8以后每次展示一个cell到屏幕上都要计算一遍。
    // 考虑到cell的内容会随时变化，比如用户调整了字体大小，那么对于缓存的高度也要及时失效。
    return cellSize.height;
}

- (void)configureCell:(JKEntityCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    JKEntity *entity = self.entities[row];
    [cell setTitle:[NSString stringWithFormat:@"Row Index: %@", @(row)]];
    [cell setContent:entity.content];
    [cell setImage:(entity.hasImage ? [UIImage imageNamed:@"Clock.png"] : nil)];
    [cell showAudio:entity.hasAudio];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - 

- (BOOL)shouldAutorotate
{
    return NO;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
