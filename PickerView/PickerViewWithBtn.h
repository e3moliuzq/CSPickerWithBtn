//
//  PickerViewWithBtn.h
//
//
//  Created by e3mo on 16/5/6.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PickerViewWithBtn : UIView <UIPickerViewDelegate,UIPickerViewDataSource> {
    UIPickerView *picker_view;
    UIButton *sure_btn;
    UIButton *cancel_btn;
    UIView *btn_menu;//btn_mode==1使用
    int btn_mode;
    UIColor *label_color;
    
    UIView *show_view;
    BOOL isInAction;
    
    NSMutableArray *picker_choose_indexs;
    NSArray *picker_array;
}

@property (readwrite, copy) void (^close) (id sender);//结束hideView动画时
@property (readwrite, copy) void (^action) (NSArray* indexs, id sender);//点击选项时

/**
 带确定按钮的picker，可多项选择，多项选择之间无联系
 */

/**
 该控件会有一个黑色半透明的遮罩，点击遮罩选择框将执行hideView动画
 frame：决定遮罩的位置大小和选择框的宽度
 chooseIndexs：传入int转NSString的数组，决定每一项选择的row
 areaArray：传入数据，array中为数组，每个数组中皆为NSString，为每一项的内容
 btn_mode:为1是按钮在选择框上方样式，为0是按钮在选择框下方样式，默认为0
 */
- (id)initWithFrame:(CGRect)frame chooseIndexs:(NSArray*)chooseIndexs areaArray:(NSArray*)array;
- (id)initWithFrame:(CGRect)frame chooseIndexs:(NSArray*)chooseIndexs areaArray:(NSArray*)array btnMode:(int)btnMode;

- (void)setCellBgColor:(UIColor*)color;//设定选择框的背景颜色
- (void)setCellLabelColor:(UIColor*)color;//设定选项文字的颜色
- (void)setBtnBgColor:(UIColor*)color;//设定确定按钮的颜色
- (void)setBtnLabelColor:(UIColor*)color highlightedColor:(UIColor*)h_color;//设定确定按钮文字的颜色，highlightedColor可不填

- (void)showView:(void (^) (NSArray *indexs, id sender))action close:(void (^) (id sender))close;//执行出现动画，初始化后需要执行
- (void)hideView;//执行隐藏动画
- (BOOL)viewIsInAction;//判断当前是否在动画过程中

@end
