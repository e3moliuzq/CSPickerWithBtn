//
//  PickerViewWithBtn.h
//
//
//  Created by e3mo on 16/5/6.
//  Copyright (c) 2016年 e3mo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewWithBtnDelegate <NSObject>

@optional
- (void)pickerWithBtnSure:(id)sender chooseIndexs:(NSArray*)indexs;
- (void)pickerWithBtnClose:(id)sender;
@end

@interface PickerViewWithBtn : UIView <UIPickerViewDelegate,UIPickerViewDataSource> {
    UIPickerView *picker_view;
    UIButton *sure_btn;
    UIColor *label_color;
    
    UIView *show_view;
    BOOL isInAction;
    
    NSMutableArray *picker_choose_indexs;
    NSArray *picker_array;
}
@property (nonatomic,weak) id<PickerViewWithBtnDelegate> delegate;

/**
 带确定按钮的picker，可多项选择，多项选择之间无联系
 */

/**
 该控件会有一个黑色半透明的遮罩，点击遮罩选择框将执行hideView动画
 frame：决定遮罩的位置大小和选择框的宽度
 chooseIndexs：传入int转NSString的数组，决定每一项选择的row
 areaArray：传入数据，array中为数组，每个数组中皆为NSString，为每一项的内容
 */
- (id)initWithFrame:(CGRect)frame chooseIndexs:(NSArray*)chooseIndexs areaArray:(NSArray*)array;

- (void)setCellBgColor:(UIColor*)color;//设定选择框的背景颜色
- (void)setBtnBgColor:(UIColor*)color;//设定确定按钮的颜色
- (void)setCellLabelColor:(UIColor*)color;//设定选项文字的颜色

- (void)showView;//执行出现动画，初始化后需要执行
- (void)hideView;//执行隐藏动画
- (BOOL)viewIsInAction;//判断当前是否在动画过程中

@end
