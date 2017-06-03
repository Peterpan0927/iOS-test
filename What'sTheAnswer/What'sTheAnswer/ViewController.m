//
//  ViewController.m
//  What'sTheAnswer
//
//  Created by Mac on 2017/5/16.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"

#import "GuessModel.h"

#define kButtonWidth 30

#define kMargin 10

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *coinButton;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSArray *dataArray;
@property (nonatomic, assign) NSInteger index;
@property (weak ,nonatomic) UIView *coverView;
@property (weak, nonatomic) IBOutlet UITextField *gua;
@end

@implementation ViewController
-(NSArray *)dataArray{
    if(_dataArray==nil){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"questions.plist" ofType:nil];
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *dict in tempArray){
            GuessModel *guessModel = [GuessModel guessModelDict:dict];
            [mutableArray addObject:guessModel];
        }
        _dataArray = mutableArray;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 1;
    [self setupUI];
    [self initCoverView];
}

- (void)initCoverView{
    UIView *coverView = [[UIView alloc]initWithFrame:self.view.bounds];
    //进行属性的关联
    self.coverView = coverView;
    coverView.alpha = 0;
    [coverView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:coverView];
}

-(void)setupUI{
    GuessModel *guessModel = self.dataArray[_index-1];
    _indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",_index, self.dataArray.count];
    _titleLabel.text = guessModel.title;
    NSString *imageName = guessModel.icon;
    [_imageButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //获取答案的长度
    NSString *answer = guessModel.answer;
    NSInteger length = answer.length;
    [self setupAnswerViewWithLength:length];
    [self setupOptionViewWithOptions:guessModel.options];
}

-(void)setupOptionViewWithOptions:(NSArray *)options{
    int column = 7;
    NSInteger count = options.count;
    CGFloat margin = (kScreenSize.width - column*kButtonWidth)/(column+1);
    [_optionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(int i = 0;i < count;i++){
        NSInteger rowIndex = i/column;
        NSInteger columnIndex = i%column;
        CGFloat buttonX = (columnIndex + 1)*margin + columnIndex*kButtonWidth;
        CGFloat buttonY = rowIndex*margin + rowIndex*kButtonWidth;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, kButtonWidth, kButtonWidth)];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted" ] forState:UIControlStateHighlighted];
        [button setTitle:options[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickOptionButton:) forControlEvents:UIControlEventTouchUpInside];
        [_optionView addSubview:button];
    }
    
}

-(void)setupAnswerViewWithLength:(NSInteger)count{
    
    CGFloat startX = (kScreenSize.width - count*kButtonWidth - (count-1)*kMargin)/2;
    //添加本题的时候要清除上一题的Button,让数组中所有的元素都执行清除方法
    [_answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(int i = 0;i < count;i++){
        CGFloat buttonX = i*kButtonWidth + i*kMargin + startX;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, kMargin, kButtonWidth, kButtonWidth)];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_answer" ] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted" ] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickAnswerButton:) forControlEvents:UIControlEventTouchUpInside];
        [_answerView addSubview:button];
    }
}

-(IBAction)nextQuestion:(UIButton *)sender {
    _index++;
    [self setupUI];
    _nextButton.enabled = (_index != self.dataArray.count);
     _optionView.userInteractionEnabled = YES;
}

-(void)didClickOptionButton:(UIButton *)optionButton{
    //取出文字
    NSString *title = optionButton.currentTitle;
    //隐藏被点击按钮
    optionButton.hidden = YES;
    //将点击的按钮文字显示到答案区域
    //obj -->数组对象
    //idx -->下标
    //stop -->判断结束
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
        UIButton *answerButton = obj;
        if(answerButton.currentTitle.length==0){
            [answerButton setTitle:title forState:UIControlStateNormal];
            *stop = YES;
        }
    }];
    __block BOOL isComplete = YES;
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
        UIButton *answerButton = obj;
        if(answerButton.currentTitle.length==0){
            isComplete = NO;
            *stop = YES;
        }
    }];
    if (isComplete) {
        //用户不能再点击选项区域中的按钮
        //userInteractionEnabled = NO,禁止任何用户交互，如果是父View设置了这个属性，那么他的子View也将不会接受用户交互
        _optionView.userInteractionEnabled = NO;
        //判断用户是否输入正确，取出用户的答案和标准答案做对比
        //取出用户答案
        NSMutableString *userAnswer = [NSMutableString string];
        [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
            UIButton *answerButton = obj;
            [userAnswer appendString:answerButton.currentTitle];
        }];
        //取出正确答案
        GuessModel *guessModel = self.dataArray[_index-1];
        NSString *rightAnswer = guessModel.answer;
        NSInteger currentCoin = _coinButton.currentTitle.integerValue;
        if ([userAnswer isEqualToString:rightAnswer]){
            //自动跳转下一题，增加一百金币
            currentCoin += 100;
            //防止最后一题回答正确后继续跳转下一题而导致报错
            if(_index != self.dataArray.count)
                [self performSelector:@selector(nextQuestion:) withObject:nil afterDelay:1];
        }else {
            //答案区域字体变红，减少500金币
            currentCoin -= 500;
            if(currentCoin < 0){
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"亲，你的钱不够了" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertView addAction:cancelAction];
                [alertView addAction:sureAction];
                [self presentViewController:alertView animated:YES completion:nil];
                return;
            }
             [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
                 UIButton *answerButton = obj;
                 
                 [answerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
             }];
        }
        NSString *coinTitle = [NSString stringWithFormat: @"%ld",currentCoin ];
        [_coinButton setTitle:coinTitle forState:UIControlStateNormal];
    }
}

-(void)didClickAnswerButton:(UIButton *)answerButton{
    //如果没有文本就直接返回
    if(answerButton.currentTitle.length == 0){
        return;
    }
    //取出文本
    NSString *title = answerButton.currentTitle;
    //清空按钮区域的文本
    [answerButton setTitle:@"" forState:UIControlStateNormal];
    [_optionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
        UIButton *optionButton = obj;
        //将选项中的相应文字显示出来
        if([optionButton.currentTitle isEqualToString:title]){
            optionButton.hidden = NO;
            *stop = YES;
        }
    }];
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
        UIButton *answerButton = obj;
        
        [answerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    //打开选项区域的用户交互
    _optionView.userInteractionEnabled=YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    //在黑色的背景下显示状态栏
    return UIStatusBarStyleLightContent;
}

- (IBAction)didClickTipButton:(UIButton *)sender {
    
    NSInteger currentCoin = _coinButton.currentTitle.integerValue;
    currentCoin -= 1000;
    //做一个判断分数是否大于1000
    if(currentCoin < 0){
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"亲，你的钱不够了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:cancelAction];
        [alertView addAction:sureAction];
        [self presentViewController:alertView animated:YES completion:nil];
        return;
    }
    NSString *coinstring = [NSString stringWithFormat:@"%ld",currentCoin];
    [_coinButton setTitle:coinstring forState:UIControlStateNormal];
    GuessModel *guessModel = self.dataArray[_index-1];
    NSString *rightAnswer = guessModel.answer;
    NSString *firststring = [rightAnswer substringToIndex:1];
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
        UIButton *answerButton = obj;
        if(idx == 0){
            [answerButton setTitle:firststring forState:UIControlStateNormal];
        }else {
            //如果不是第一个字符串，则清空
            [answerButton setTitle:@"" forState:UIControlStateNormal];
        }
        
    }];
    [_optionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
        UIButton *optionButton = obj;
        if([optionButton.currentTitle isEqualToString:firststring]){
            //如果字符串相等，就把button隐藏
            optionButton.hidden = YES;
        }else{
            //如果不是第一个就要回到原位
            optionButton.hidden = NO;
        }
    }];
    [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,NSUInteger idx, BOOL *_Nonnull stop){
        UIButton *answerButton = obj;
        
        [answerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }];
    _optionView.userInteractionEnabled = YES;
}
- (IBAction)didClickimageButton:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
         _coverView.alpha = 0.6;
        //将图片放大至原来的1.5倍
        _imageButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }];
    [self.view addSubview:_coverView];
    //将图片按钮放在coverView的上面
    [self.view bringSubviewToFront:_imageButton];
}
- (IBAction)didClickBigImageButton:(id)sender {
        //通过coverView的alpha值作判断
        if(_coverView.alpha == 0)
        {
            [self didClickimageButton:nil];
        }else {
            [UIView animateWithDuration:0.5 animations:^{
        //将透明度和图片的大小复原
                _coverView.alpha = 0;
                //CGAffineTransformIdentity如果赋值回去，那么之前通过transform改变的属性都会复原
                _imageButton.transform = CGAffineTransformIdentity;
            }];
        }
}
- (IBAction)didClickHelp:(id)sender {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"亲爱的玩家" message:@"你需要我们的帮助吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"通道入口" message:@"请问你是哪种类型的玩家呢？" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"非RMB" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"智障！！！" message:@"没钱玩个毛，滚犊子！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"我这就滚～" style:UIAlertActionStyleDefault handler:nil];
            [alertView addAction:sureAction];
             [self presentViewController:alertView animated:YES completion:nil];
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"RMB" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"尊敬的玩家" message:@"我的支付宝账号是15629085780，我们加个好友慢慢聊" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"我马上加" style:UIAlertActionStyleDefault handler:nil];
            [alertView addAction:sureAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }];
        [alertView addAction:cancelAction];
        [alertView addAction:sureAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }];
    [alertView addAction:cancelAction];
    [alertView addAction:sureAction];
    [self presentViewController:alertView animated:YES completion:nil];
}
- (IBAction)kaigua:(id)sender {
    if ([self.gua.text isEqualToString:@"Kana"]) {
         UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"特殊的玩家" message:@"题目的答案问问你旁边的人就知道了哟" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"这真是个好主意" style:UIAlertActionStyleDefault handler:nil];
        [alertView addAction:sureAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }else if ([self.gua.text isEqualToString:@"潘振鹏"]){
        NSInteger currentCoin = _coinButton.currentTitle.integerValue;
        currentCoin += 10000;
        NSString *coinString = [NSString stringWithFormat:@"%ld", currentCoin];
        [_coinButton setTitle:coinString forState:UIControlStateNormal];
    }
}



@end
