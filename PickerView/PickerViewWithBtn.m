//
//  PickerViewWithBtn.m
//  shjManager
//
//  Created by e3mo on 16/5/6.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import "PickerViewWithBtn.h"

@implementation PickerViewWithBtn

- (id)initWithFrame:(CGRect)frame chooseIndexs:(NSArray*)chooseIndexs areaArray:(NSArray *)array {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        isInAction = NO;
        picker_choose_indexs = [[NSMutableArray alloc] initWithArray:chooseIndexs];
        
        picker_array = [[NSArray alloc] initWithArray:array];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        label_color = [UIColor blackColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [btn addTarget:self action:@selector(closeBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [self initShowView];
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

- (void)initShowView {
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
    
    height = picker_view.frame.size.height+5;
    
    [show_view addSubview:picker_view];
    
    for (int i=0; i<picker_choose_indexs.count; i++) {
        int index = [[picker_choose_indexs objectAtIndex:i] intValue];
        [picker_view selectRow:index inComponent:i animated:YES];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerWithBtnSure:chooseIndexs:)]) {
        [self.delegate pickerWithBtnSure:self chooseIndexs:picker_choose_indexs];
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
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(pickerWithBtnClose:)]) {
                [self.delegate pickerWithBtnClose:self];
            }
        }
    }];
}

- (BOOL)viewIsInAction {
    return isInAction;
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {//设置picker有几个模块
    return picker_array.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {//每个模块中有几行
    if (component < 0 || component >= picker_array.count) {
        return 0;
    }
    
    NSArray *arr = [picker_array objectAtIndex:component];
    return arr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {//模块宽度
    CGSize winsize = [[UIScreen mainScreen] bounds].size;
    return winsize.width/picker_array.count;
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
    
    NSArray *arr = [picker_array objectAtIndex:component];
    NSString *name = [arr objectAtIndex:row];
    
    [retval setText:name];
    
    return retval;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {//选择后操作
    [picker_choose_indexs replaceObjectAtIndex:component withObject:[NSString stringWithFormat:@"%d",(int)row]];
}



@end
