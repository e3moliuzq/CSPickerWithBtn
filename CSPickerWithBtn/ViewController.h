//
//  ViewController.h
//  CSPickerWithBtn
//
//  Created by e3mo on 16/5/6.
//  Copyright © 2016年 e3mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerWithBtn.h"
#import "PickerViewWithBtn.h"

@interface ViewController : UIViewController <datePickerWithBtnDelegate,PickerViewWithBtnDelegate> {
    DatePickerWithBtn *date_picker_view;
    NSDate *choose_date;
    PickerViewWithBtn *picker_view;
    int choose_index[2];
    UIButton *btn0;
    UIButton *btn1;
}


@end

