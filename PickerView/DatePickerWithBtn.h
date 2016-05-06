//
//  DatePickerWithBtn.h
//
//
//  Created by e3mo on 16/5/6.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    datePickerModeYMD = 0,
    datePickerModeYM = 1,
} datePickerMode;


@protocol datePickerWithBtnDelegate <NSObject>

@optional
- (void)datePickerWithBtnSure:(id)sender chooseDate:(NSDate*)date;
- (void)datePickerWithBtnClose:(id)sender;
@end

@interface DatePickerWithBtn : UIView <UIPickerViewDataSource,UIPickerViewDelegate> {
    UIPickerView *picker_view;
    UIButton *sure_btn;
    UIColor *label_color;
    
    int choose_year_index;
    int choose_month_index;
    int choose_day_index;
    
    int picker_mode;
    
    NSDate *max_date;
    int min_year;
    
    UIView *show_view;
    BOOL isInAction;
}
@property (nonatomic,weak) id<datePickerWithBtnDelegate> delegate;

/**
 带确定按钮的datepicker，可显示年月日或年月
 */

/**
 该控件会有一个黑色半透明的遮罩，点击遮罩选择框将执行hideView动画
 frame：决定遮罩的位置大小和选择框的宽度
 chooseDate：当前选择的日期
 mode：datePickerModeYMD为显示年月日，datePickerModeYM为显示年月
 */
- (id)initWithFrame:(CGRect)frame chooseDate:(NSDate*)chooseDate mode:(int)mode;

- (void)setCellBgColor:(UIColor*)color;//设定选择框的背景颜色
- (void)setCellLabelColor:(UIColor*)color;//设定选项文字的颜色
- (void)setBtnBgColor:(UIColor*)color;//设定确定按钮的颜色
- (void)setBtnLabelColor:(UIColor*)color highlightedColor:(UIColor*)h_color;//设定确定按钮文字的颜色，highlightedColor可不填

- (void)setMaxDate:(NSDate*)date;//设定最大日期
- (void)setMinYear:(int)minYear;//设定最小年份，最小月和日默认为1月1日

- (void)showView;//执行出现动画，初始化后需要执行
- (void)hideView;//执行隐藏动画
- (BOOL)viewIsInAction;//判断当前是否在动画过程中


+ (NSDate*)dateFromYear:(int)year month:(int)month day:(int)day;//传入年月日转换为NSDate
+ (NSUInteger)day:(NSDate*)date;//传入NSDate获取日
+ (NSUInteger)month:(NSDate*)date;//传入NSDate获取月
+ (NSUInteger)year:(NSDate*)date;//传入NSDate获取年
+ (NSString*)dateString:(NSDate*)date format:(NSString*)format;//传入NSDate转换为日期NSString，格式自定义，如：@"YYYY-MM-DD HH:mm:ss"
+ (NSUInteger)numberOfDaysInCurrentMonth:(NSDate*)date;//获得该月天数
+ (NSDate*)firstDayOfCurrentMonth:(NSDate*)date;//获得该月第一天的NSDate

@end
