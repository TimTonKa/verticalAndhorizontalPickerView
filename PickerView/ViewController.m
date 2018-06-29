//
//  ViewController.m
//  PickerView
//
//  Created by Tim on 2018/5/18.
//  Copyright © 2018年 Tim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

//@property (weak, nonatomic) IBOutlet UIPickerView *horizontalPickerView;
//@property (weak, nonatomic) IBOutlet UIPickerView *verticalPickerView;

@property (strong, nonatomic) UIPickerView *horizontalPickerView;
@property (strong, nonatomic) UIPickerView *verticalPickerView;


@property (strong, nonatomic) NSArray *horizontalDataArray;
@property (strong, nonatomic) NSArray *verticalDataArray;

@end

@implementation ViewController

-(void)initHorizontalPickerViewWithFrame:(CGRect)frame {
	
	CGRect newFrame = frame;
	CGFloat ratationAngle = -90 * (M_PI/180);
	
	self.horizontalPickerView = [[UIPickerView alloc] initWithFrame:frame];
	self.horizontalPickerView.transform = CGAffineTransformMakeRotation(ratationAngle);
	self.horizontalPickerView.frame = newFrame;
	self.horizontalPickerView.delegate = self;
	self.horizontalPickerView.dataSource = self;
	
	[self.view addSubview:self.horizontalPickerView];
}

-(void)initVerticalPickerViewWithFrame:(CGRect)frame {
	
	self.verticalPickerView = [[UIPickerView alloc] initWithFrame:frame];
	self.verticalPickerView.delegate = self;
	self.verticalPickerView.dataSource = self;
	
	[self.view addSubview:self.verticalPickerView];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.horizontalDataArray = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g"];
	self.verticalDataArray = @[@"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1"];
	
	CGRect hFrame = CGRectMake(0, 100, self.view.frame.size.width, 150);
	[self initHorizontalPickerViewWithFrame:hFrame];
	
	CGRect vFrame = CGRectMake(0, CGRectGetMaxY(hFrame) + 50, self.view.frame.size.width, 150);
	[self initVerticalPickerViewWithFrame:vFrame];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
	if (pickerView == self.horizontalPickerView) {
		
		//Hide lines
		[self.horizontalPickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			
			obj.hidden = (CGRectGetHeight(obj.frame) < 1.0);
		}];
		
		return 1;
	} else {
		return 1;
	}
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (pickerView == self.horizontalPickerView) {
		return self.horizontalDataArray.count;
	} else {
		return self.verticalDataArray.count;
	}
}


- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
	return true;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	
	CGRect frame = CGRectMake(0, 0, 120, 100);
	UIView *reusingView = [[UIView alloc] initWithFrame:frame];
	
	UILabel *numberLabel = [[UILabel alloc] initWithFrame:frame];
	numberLabel.textAlignment = NSTextAlignmentCenter;
	if (pickerView == self.horizontalPickerView) {
		CGFloat ratationAngle = 90 * (M_PI / 180);
		numberLabel.text = self.horizontalDataArray[row];
		[reusingView addSubview:numberLabel];
		
		reusingView.transform = CGAffineTransformMakeRotation(ratationAngle);
	} else {
		numberLabel.text = self.verticalDataArray[row];
		[reusingView addSubview:numberLabel];
	}
	
	
	return reusingView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	
	return 120;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return 100;
}


@end
