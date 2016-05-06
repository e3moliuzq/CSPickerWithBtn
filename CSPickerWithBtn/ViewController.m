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
        date_picker_view.delegate = self;
        NSDate *date = [DatePickerWithBtn dateFromYear:2016 month:12 day:12];
        [date_picker_view setMaxDate:date];
        [date_picker_view setMinYear:1990];
        [self.view addSubview:date_picker_view];
        [date_picker_view showView];
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
        picker_view.delegate = self;
        [picker_view setCellBgColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9]];
        [picker_view setBtnBgColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9]];
        [picker_view setCellLabelColor:[UIColor whiteColor]];
        [picker_view setBtnLabelColor:[UIColor redColor] highlightedColor:[UIColor darkGrayColor]];
        [self.view addSubview:picker_view];
        [picker_view showView];
        
    }
}

#pragma mark - datepicker delegate
- (void)datePickerWithBtnClose:(id)sender {
    [date_picker_view removeFromSuperview];
    date_picker_view = nil;
}

- (void)datePickerWithBtnSure:(id)sender chooseDate:(NSDate *)date {
    choose_date = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:choose_date];
    
    [btn0 setTitle:[NSString stringWithFormat:@"show date picker with button:%@",dateStr] forState:UIControlStateNormal];
    
    [date_picker_view hideView];
}


#pragma mark - pickerbtn delegate
- (void)pickerWithBtnClose:(id)sender {
    [picker_view removeFromSuperview];
    picker_view = nil;
}

- (void)pickerWithBtnSure:(id)sender chooseIndexs:(NSArray *)indexs {
    choose_index[0] = [[indexs objectAtIndex:0] intValue];
    choose_index[1] = [[indexs objectAtIndex:1] intValue];
    
    [btn1 setTitle:[NSString stringWithFormat:@"show picker view with button:%@-%@",[test_arr0 objectAtIndex:choose_index[0]],[test_arr1 objectAtIndex:choose_index[1]]] forState:UIControlStateNormal];
    
    [picker_view hideView];
}


@end
