//
//  ViewController.m
//  CSPickerWithBtn
//
//  Created by e3mo on 16/5/6.
//  Copyright © 2016年 e3mo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSArray *test_arr0;
    NSArray *test_arr1;
    NSArray *contact_test_arr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    
    choose_date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:choose_date];
    
    btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setFrame:CGRectMake(30, winsize.height-100, 230, 80)];
    [btn0 setTitle:[NSString stringWithFormat:@"show date picker with button:%@",dateStr] forState:UIControlStateNormal];
    btn0.titleLabel.numberOfLines = 0;
    [btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn0 setBackgroundColor:[UIColor redColor]];
    [btn0 addTarget:self action:@selector(datepickerTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    choose_index[0] = 0;
    choose_index[1] = 0;
    test_arr0 = [NSArray arrayWithObjects: @"数据0", @"数据1", @"数据2", @"数据3", nil];
    test_arr1 = [NSArray arrayWithObjects: @"活动0", @"活动1", @"活动2", @"活动3", nil];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(30, winsize.height-200, 230, 80)];
    [btn1 setTitle:[NSString stringWithFormat:@"show picker view with button:%@-%@",[test_arr0 objectAtIndex:choose_index[0]],[test_arr1 objectAtIndex:choose_index[1]]] forState:UIControlStateNormal];
    btn1.titleLabel.numberOfLines = 0;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(pickerviewTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    choose_contact[0] = 0;
    choose_contact[1] = 0;
    choose_contact[2] = 0;
    
    
    
    contact_test_arr = @[
                         @{@"name":@"数据0",@"array":@[
                                   @{@"name":@"活动00", @"array":@[
                                             @{@"name":@"选项000"},@{@"name":@"选项001"},@{@"name":@"选项002"}
                                             ]},
                                   @{@"name":@"活动01", @"array":@[
                                             @{@"name":@"选项010"},@{@"name":@"选项011"},@{@"name":@"选项012"},@{@"name":@"选项013"}
                                             ]},
                                   @{@"name":@"活动02", @"array":@[
                                             @{@"name":@"选项020"},@{@"name":@"选项021"}
                                             ]},
                                   ]},
                         @{@"name":@"数据1",@"array":@[
                                   @{@"name":@"活动10", @"array":@[
                                             @{@"name":@"选项100"},@{@"name":@"选项101"},@{@"name":@"选项102"}
                                             ]},
                                   @{@"name":@"活动11", @"array":@[
                                             @{@"name":@"选项110"},@{@"name":@"选项111"}
                                             ]},
                                   @{@"name":@"活动12", @"array":@[
                                             @{@"name":@"选项120"},@{@"name":@"选项121"},@{@"name":@"选项122"}
                                             ]},
                                   @{@"name":@"活动13", @"array":@[
                                             @{@"name":@"选项130"},@{@"name":@"选项131"},@{@"name":@"选项132"},@{@"name":@"选项133"},@{@"name":@"选项134"}
                                             ]},
                                   ]},
                         
                         @{@"name":@"数据2",@"array":@[
                                   @{@"name":@"活动20", @"array":@[
                                             @{@"name":@"选项200"},@{@"name":@"选项201"}
                                             ]},
                                   @{@"name":@"活动21", @"array":@[
                                             @{@"name":@"选项210"},@{@"name":@"选项211"},@{@"name":@"选项202"}
                                             ]},
                                   ]},
                         ];
    
    NSDictionary *dict0 = [contact_test_arr objectAtIndex:choose_contact[0]];
    NSString *name0 = [dict0 objectForKey:@"name"];
    NSArray *arr1 = [dict0 objectForKey:@"array"];
    NSDictionary *dict1 = [arr1 objectAtIndex:choose_contact[1]];
    NSString *name1 = [dict1 objectForKey:@"name"];
    NSArray *arr2 = [dict1 objectForKey:@"array"];
    NSDictionary *dict2 = [arr2 objectAtIndex:choose_contact[2]];
    NSString *name2 = [dict2 objectForKey:@"name"];
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(30, winsize.height-300, 230, 80)];
    [btn2 setTitle:[NSString stringWithFormat:@"show contact picker with button:%@-%@-%@",name0,name1,name2] forState:UIControlStateNormal];
    btn2.titleLabel.numberOfLines = 0;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(contactpickerTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)datepickerTouched {
    if (date_picker_view) {
        if ([date_picker_view viewIsInAction]) {
            return;
        }
        
        [date_picker_view hideView];
    }
    else {
        CGSize winsize = [[UIScreen mainScreen] bounds].size;
        
        date_picker_view = [[DatePickerWithBtn alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) chooseDate:choose_date mode:datePickerModeYMD];
        NSDate *date = [DatePickerWithBtn dateFromYear:2016 month:12 day:12];
        [date_picker_view setMaxDate:date];
        [date_picker_view setMinYear:1990];
        [self.view addSubview:date_picker_view];
        [date_picker_view showView:^(NSDate *date, id sender) {
            choose_date = date;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateStr = [dateFormatter stringFromDate:choose_date];
            
            [btn0 setTitle:[NSString stringWithFormat:@"show date picker with button:%@",dateStr] forState:UIControlStateNormal];
            
            [date_picker_view hideView];
        } close:^(id sender) {
            [date_picker_view removeFromSuperview];
            date_picker_view = nil;
        }];
    }
}

- (void)pickerviewTouched {
    if (picker_view) {
        if ([picker_view viewIsInAction]) {
            return;
        }
        
        [picker_view hideView];
    }
    else {
        CGSize winsize = [[UIScreen mainScreen] bounds].size;
        
        picker_view = [[PickerViewWithBtn alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) chooseIndexs:[NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",choose_index[0]], [NSString stringWithFormat:@"%d",choose_index[1]], nil] areaArray:[NSArray arrayWithObjects: test_arr0, test_arr1, nil]];
        [picker_view setCellBgColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9]];
        [picker_view setBtnBgColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9]];
        [picker_view setCellLabelColor:[UIColor whiteColor]];
        [picker_view setBtnLabelColor:[UIColor redColor] highlightedColor:[UIColor darkGrayColor]];
        [self.view addSubview:picker_view];
        [picker_view showView:^(NSArray *indexs, id sender) {
            choose_index[0] = [[indexs objectAtIndex:0] intValue];
            choose_index[1] = [[indexs objectAtIndex:1] intValue];
            
            [btn1 setTitle:[NSString stringWithFormat:@"show picker view with button:%@-%@",[test_arr0 objectAtIndex:choose_index[0]],[test_arr1 objectAtIndex:choose_index[1]]] forState:UIControlStateNormal];
            
            [picker_view hideView];
        } close:^(id sender) {
            [picker_view removeFromSuperview];
            picker_view = nil;
        }];
    }
}

- (void)contactpickerTouched {
    if (contact_picker) {
        if ([contact_picker viewIsInAction]) {
            return;
        }
        
        [contact_picker hideView];
    }
    else {
        CGSize winsize = [[UIScreen mainScreen] bounds].size;
        
        NSArray *choose_indexs = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",choose_contact[0]], [NSString stringWithFormat:@"%d",choose_contact[1]], [NSString stringWithFormat:@"%d",choose_contact[2]], nil];
        contact_picker = [[ContactPickerWithBtn alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) chooseIndexs:choose_indexs infoArray:contact_test_arr];
        [self.view addSubview:contact_picker];
        [contact_picker showView:^(NSArray *indexs, id sender) {
            choose_contact[0] = [[indexs objectAtIndex:0] intValue];
            choose_contact[1] = [[indexs objectAtIndex:1] intValue];
            choose_contact[2] = [[indexs objectAtIndex:2] intValue];
            
            NSDictionary *dict0 = [contact_test_arr objectAtIndex:choose_contact[0]];
            NSString *name0 = [dict0 objectForKey:@"name"];
            NSArray *arr1 = [dict0 objectForKey:@"array"];
            NSDictionary *dict1 = [arr1 objectAtIndex:choose_contact[1]];
            NSString *name1 = [dict1 objectForKey:@"name"];
            NSArray *arr2 = [dict1 objectForKey:@"array"];
            NSDictionary *dict2 = [arr2 objectAtIndex:choose_contact[2]];
            NSString *name2 = [dict2 objectForKey:@"name"];
            
            [btn2 setTitle:[NSString stringWithFormat:@"show contact picker with button:%@-%@-%@",name0,name1,name2] forState:UIControlStateNormal];
            
            
            [contact_picker hideView];
        } close:^(id sender) {
            [contact_picker removeFromSuperview];
            contact_picker = nil;
        }];
    }
}


@end
