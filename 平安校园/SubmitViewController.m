//
//  SubmitViewController.m
//  Car
//
//  Created by Max on 16/5/18.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "SubmitViewController.h"

@interface SubmitViewController ()

@property (weak, nonatomic) IBOutlet UITextView *dataText;


@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (_message!=nil) {
//        NSMutableString *str3 = [NSMutableString stringWithFormat:@"%@,%@",_message,_message1];
//
//        self.dataText.text = str3;
//        NSLog(@"%@",str3);
//    }else {
    
        self.dataText.text = _message;
//        self.dataText.text = _message1;
    
    //}
    
    
    
    
//    NSMutableString* s = [NSMutableString string];
//    
//    for (NSString* colour in _message) {
//        
//        NSArray* array = [colour componentsSeparatedByString:@":"];
//        
//        if (array.count == 2) { // 容错
//            
//            if (s.length > 0) {
//                
//                [s appendString:@","];
//                
//            }
//            
//            [s appendString:[array objectAtIndex:1]];
//            
//        }
//        
//    }
   //   NSLog(@"message[%d]=%@", i, _message[i]);
    //label.text = s;
    //NSLog(@"%@",str);
    //    for (int i = 0; i<_message.count; i++) {
    //        [str appendString:[_message objectAtIndex:_message.count]];
    //       }

//    NSMutableString* str = [NSMutableString string];
//    for (int i = 0; i<_message.count; i++) {
//        //str = [NSMutableString stringWithFormat:@","];
//        if (_message.count > 2) {
//        str = [str stringByAppendingString:@"\n"];
//        }
//        str = [str stringByAppendingString:_message[i]];
//        NSLog(@"%@",str);
//    }
    
    
    
    //self.dataText.text = _message;

    }

@end
