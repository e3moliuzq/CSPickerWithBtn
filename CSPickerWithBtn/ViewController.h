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
#import "ContactPickerWithBtn.h"

@interface ViewController : UIViewController {
    DatePickerWithBtn *date_picker_view;
    NSDate *choose_date;
    PickerViewWithBtn *picker_view;
    ContactPickerWithBtn *contact_picker;
    int choose_index[2];
    int choose_contact[3];
    UIButton *btn0;
    UIButton *btn1;
    UIButton *btn2;
}


@end

