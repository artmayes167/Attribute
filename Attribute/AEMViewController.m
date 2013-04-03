//
//  AEMViewController.m
//  Attribute
//
//  Created by Arthur Mayes on 2/5/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "AEMViewController.h"

@interface AEMViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;

@end

@implementation AEMViewController

-(void)addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
        [mat addAttributes:attributes range:range];
        self.label.attributedText = mat;
    }
}

-(void)addSelectedWordAttributes:(NSDictionary *)attributes{
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
    
}
- (IBAction)underline:(id)sender {
    
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    
    
}
- (IBAction)noUnderline:(id)sender {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}

- (IBAction)outline:(id)sender {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName : @-5,
        NSStrokeColorAttributeName : [UIColor yellowColor]}];
}

- (IBAction)noOutline:(id)sender {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName : @0}];
}

- (IBAction)changeColor:(UIButton *)sender {
    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName : sender.backgroundColor}];
}
- (IBAction)changeFont:(UIButton *)sender {
    CGFloat fontSize = [UIFont systemFontSize];
    NSDictionary *attributes = [self.label.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    if (existingFont) fontSize = existingFont.pointSize;
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize   ];
    
    [self addSelectedWordAttributes:@{NSFontAttributeName : font}];
}

-(NSArray *)wordList{
    NSArray *wordlist = [[self.label.attributedText string] componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (wordlist.count) {
        return wordlist;
    } else {
        return @[@""];
    }
}

-(NSString *) selectedWord{
    return [self wordList][(int)self.selectedWordStepper.value];
}
- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList] count]-1;
    self.selectedWordLabel.text = [self selectedWord];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    [self updateSelectedWord];
}

@end
