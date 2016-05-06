//
//  DatePickerWithBtn.m
//  shjManager
//
//  Created by e3mo on 16/5/6.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import "DatePickerWithBtn.h"

@implementation DatePickerWithBtn


- (id)initWithFrame:(CGRect)frame chooseDate:(NSDate *)chooseDate mode:(int)mode {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        picker_mode = mode;
        isInAction = NO;
        
        max_date = [NSDate date];
        min_year = 1970;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [btn addTarget:self action:@selector(closeBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [self initShowView:chooseDate];
    }
    
    return self;
}

- (void)setCellBgColor:(UIColor*)color {
    if (picker_view) {
        [picker_view setBackgroundColor:color];
    }
}

- (void)setBtnBgColor:(UIColor*)color {
    if (sure_btn) {
        [sure_btn setBackgroundColor:color];
    }
}

- (void)setCellLabelColor:(UIColor*)color {
    if (color) {
        label_color = color;
        [picker_view reloadAllComponents];
    }
}

- (void)setMaxDate:(NSDate*)date {
    if (date) {
        max_date = date;
        
        [picker_view reloadAllComponents];
        
        int year = (int)[DatePickerWithBtn year:max_date];
        int month = (int)[DatePickerWithBtn month:max_date];
        
        if (choose_year_index+min_year > year) {
            choose_year_index = year-min_year;
            [picker_view selectRow:choose_year_index inComponent:0 animated:NO];
        }
        
        if (choose_year_index+min_year == year && choose_month_index+1 > month) {
            choose_month_index = month-1;
            [picker_view selectRow:choose_month_index inComponent:1 animated:NO];
        }
        
        if (picker_mode == datePickerModeYMD) {
            NSDate *date = [DatePickerWithBtn dateFromYear:choose_year_index+min_year month:choose_month_index+1 day:1];
            NSUInteger number = [DatePickerWithBtn numberOfDaysInCurrentMonth:date];
            
            if (choose_year_index+min_year == year && choose_month_index+1 == month) {
                number = [DatePickerWithBtn day:max_date];
            }
            
            if (choose_day_index+1 > number) {
                choose_day_index = (int)number-1;
                [picker_view selectRow:choose_day_index inComponent:2 animated:NO];
            }
        }
        
        [picker_view reloadAllComponents];
    }
}

- (void)setMinYear:(int)minYear {
    int year = (int)[DatePickerWithBtn year:max_date];
    if (minYear > 0 && minYear <= year) {
        int old_min_year = min_year;
        min_year = minYear;
        
        choose_year_index += old_min_year-min_year;
        [picker_view reloadAllComponents];
        [picker_view selectRow:choose_year_index inComponent:0 animated:NO];
    }
}

- (void)initShowView:(NSDate*)chooseDate {
    show_view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
    [show_view setBackgroundColor:[UIColor clearColor]];
    [self addSubview:show_view];
    
    float height = 0;
    picker_view = [[UIPickerView alloc] init];
    [picker_view setFrame:CGRectMake(0, 0, show_view.frame.size.width, picker_view.frame.size.height)];
    [picker_view setDataSource:self];
    [picker_view setDelegate:self];
    [picker_view setShowsSelectionIndicator:YES];//选择框，貌似不能去除
    [picker_view setBackgroundColor:[UIColor whiteColor]];
    [show_view addSubview:picker_view];
    
    height = picker_view.frame.size.height+5;
    
    choose_year_index = (int)[DatePickerWithBtn year:chooseDate] - min_year;
    choose_month_index = (int)[DatePickerWithBtn month:chooseDate] - 1;
    
    [picker_view selectRow:choose_year_index inComponent:0 animated:NO];
    [picker_view selectRow:choose_month_index inComponent:1 animated:NO];
    
    if (picker_mode == datePickerModeYMD) {
        choose_day_index = (int)[DatePickerWithBtn day:chooseDate] - 1;
        
        NSDate *date = [DatePickerWithBtn dateFromYear:choose_year_index+min_year month:choose_month_index+1 day:1];
        NSUInteger number = [DatePickerWithBtn numberOfDaysInCurrentMonth:date];
        if (choose_day_index > number) {
            choose_day_index = (int)number;
        }
        [picker_view selectRow:choose_day_index inComponent:2 animated:NO];
    }
    else {
        choose_day_index = 0;
    }
    
    sure_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sure_btn setFrame:CGRectMake(0, height, show_view.frame.size.width, 44)];
    [sure_btn setTitle:@"确定" forState:UIControlStateNormal];
    [sure_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure_btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [sure_btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [sure_btn setBackgroundColor:[UIColor colorWithRed:1.f/255.f green:185.f/255.f blue:97.f/255.f alpha:1]];
    [sure_btn addTarget:self action:@selector(sureBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [show_view addSubview:sure_btn];
    
    CGRect frame = show_view.frame;
    frame.size.height = height + sure_btn.frame.size.height;
    show_view.frame = frame;
}

- (void)sureBtnTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerWithBtnSure:chooseDate:)]) {
        NSDate *date = [DatePickerWithBtn dateFromYear:choose_year_index+min_year month:choose_month_index+1 day:choose_day_index+1];
        [self.delegate datePickerWithBtnSure:self chooseDate:date];
    }
}

- (void)closeBtnTouched:(id)sender {
    if (isInAction) {
        return;
    }
    
    [self hideView];
}

- (void)showView {
    if (isInAction) {
        return;
    }
    isInAction = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = show_view.frame;
        frame.origin.y = self.frame.size.height-frame.size.height;
        show_view.frame = frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            isInAction = NO;
        }
    }];
}

- (void)hideView {
    if (isInAction) {
        return;
    }
    isInAction = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = show_view.frame;
        frame.origin.y = self.frame.size.height;
        show_view.frame = frame;
        
    } completion:^(BOOL finished) {
        if (finished) {
            isInAction = NO;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerWithBtnClose:)]) {
                [self.delegate datePickerWithBtnClose:self];
            }
        }
    }];
}

- (BOOL)viewIsInAction {
    return isInAction;
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {//设置picker有几个模块
    if (picker_mode == datePickerModeYMD) {
        return 3;
    }
    else {
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {//每个模块中有几行
    if (component == 0) {
        int year = (int)[DatePickerWithBtn year:max_date];
        int index = year - min_year + 1;
        return index;
    }
    else if (component == 1) {
        int year = (int)[DatePickerWithBtn year:max_date];
        if (choose_year_index+min_year == year) {
            int month = (int)[DatePickerWithBtn month:max_date];
            return month;
        }
        else {
            return 12;
        }
    }
    else if (component == 2) {
        int year = (int)[DatePickerWithBtn year:max_date];
        int month = (int)[DatePickerWithBtn month:max_date];
        if (choose_year_index+min_year == year && choose_month_index+1 == month) {
            int day = (int)[DatePickerWithBtn day:max_date];
            return day;
        }
        else {
            NSDate *date = [DatePickerWithBtn dateFromYear:choose_year_index+min_year month:choose_month_index+1 day:1];
            NSUInteger number = [DatePickerWithBtn numberOfDaysInCurrentMonth:date];
            return number;
        }
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {//模块宽度
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    if (picker_mode == datePickerModeYMD) {
        return winsize.width/3;
    }
    else {
        return winsize.width/2;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {//行高
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {//设置文字
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:view.bounds];
    }
    retval.textAlignment = NSTextAlignmentCenter;
    retval.font = [UIFont systemFontOfSize:17];
    retval.backgroundColor = [UIColor clearColor];
    retval.textColor = label_color;
    
    NSString *st;
    if (component == 0) {
        st = [NSString stringWithFormat:@"%d年",min_year+(int)row];
    }
    else if (component == 1) {
        st = [NSString stringWithFormat:@"%d月",(int)row+1];
    }
    else if (component == 2) {
        st = [NSString stringWithFormat:@"%d日",(int)row+1];
    }
    
    [retval setText:st];
    
    return retval;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {//选择后操作
    if (component == 0) {
        choose_year_index = (int)row;
        
        [picker_view reloadComponent:1];
        
        int year = (int)[DatePickerWithBtn year:max_date];
        if (choose_year_index+min_year == year) {
            int month = (int)[DatePickerWithBtn month:max_date];
            if (choose_month_index+1 > month) {
                choose_month_index = month-1;
                
                [picker_view selectRow:choose_month_index inComponent:1 animated:NO];
            }
        }
        
        if (picker_mode == datePickerModeYMD) {
            [picker_view reloadComponent:2];
            
            NSDate *date = [DatePickerWithBtn dateFromYear:choose_year_index+min_year month:choose_month_index+1 day:1];
            NSUInteger number = [DatePickerWithBtn numberOfDaysInCurrentMonth:date];
            
            int year = (int)[DatePickerWithBtn year:max_date];
            int month = (int)[DatePickerWithBtn month:max_date];
            if (choose_year_index+min_year == year && choose_month_index+1 == month) {
                number = [DatePickerWithBtn day:max_date];
            }
            
            if (choose_day_index+1 > number) {
                choose_day_index = (int)number-1;
                [picker_view selectRow:choose_day_index inComponent:2 animated:NO];
            }
        }
    }
    else if (component == 1) {
        choose_month_index = (int)row;
        
        if (picker_mode == datePickerModeYMD) {
            [picker_view reloadComponent:2];
            
            NSDate *date = [DatePickerWithBtn dateFromYear:choose_year_index+min_year month:choose_month_index+1 day:1];
            NSUInteger number = [DatePickerWithBtn numberOfDaysInCurrentMonth:date];
            
            int year = (int)[DatePickerWithBtn year:max_date];
            int month = (int)[DatePickerWithBtn month:max_date];
            if (choose_year_index+min_year == year && choose_month_index+1 == month) {
                number = [DatePickerWithBtn day:max_date];
            }
            
            if (choose_day_index+1 > number) {
                choose_day_index = (int)number-1;
                [picker_view selectRow:choose_day_index inComponent:2 animated:NO];
            }
        }
    }
    else {
        choose_day_index = (int)row;
    }
}


#pragma mark - date math
+ (NSDate*)dateFromYear:(int)year month:(int)month day:(int)day {
    NSString *date_st = [NSString stringWithFormat:@"%d-%d-%d",year,month,day];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:date_st];
}

//获得该月天数
+ (NSUInteger)numberOfDaysInCurrentMonth:(NSDate*)date {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

//获得该月第一天的NSDate
+ (NSDate*)firstDayOfCurrentMonth:(NSDate*)date {
    NSDate *startDate = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:date];
    return startDate;
}

+ (NSUInteger)day:(NSDate*)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return [comps day];
}

+ (NSUInteger)month:(NSDate*)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return [comps month];
}

+ (NSUInteger)year:(NSDate*)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return [comps year];
}

+ (NSString*)dateString:(NSDate*)date format:(NSString*)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

@end
