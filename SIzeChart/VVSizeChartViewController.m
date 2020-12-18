//
//  VVSizeChartViewController.m
//  Vova
//
//  Created by Dwayne on 2018/8/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "VVAdultShoeStandSizeTableView.h"
#import "VVSizeChartTableView.h"
#import "VVSizeChartViewController.h"
#import "VVSizeListModel.h"
#import "VVStandardSizeListModel.h"

#import "VVStandardSizeListModel.h"
#import "TDViewControllerPresentAndDismiss.h"
#import "UIView+TDTap.h"
//#import "VVProductDetailFreeBuyView.h"
#import "VVProductDetailUpComingRemindHelp.h"

@implementation VVSizeChartViewControllerConfiguration

@end

@interface VVSizeChartViewController ()
@property (nonatomic, strong) TDViewControllerPresentAndDismiss *presentAndDismissViewModel;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addCartButton;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, assign) CGFloat contextHeight;
@property (nonatomic, assign) BOOL isOutOfStock;
@property (nonatomic, strong) NSArray   <VVSizeListModel *> *dataArray;
@property (nonatomic, strong) NSArray   <VVStandardSizeGenderModel *> *standardSizeArray;
//保存了标准尺码表头部的一行标题
@property (nonatomic, strong) NSArray   <NSString *> *standSizeKeyArray;
//二维数组，其中的每个小数组是保存了一行的CM 数据
@property (nonatomic, strong) NSArray   <NSArray *> *cmsizeArray;
//二维数组其中的每个小数组保存了一行需要展示的inch 数据
@property (nonatomic, strong) NSArray   <NSArray *> *inchsizeArray;
@property (nonatomic, copy) NSString *tips;
@property (nonatomic, strong) VVSizeChartTableView *table;
@property (nonatomic, strong) VVAdultShoeStandSizeTableView *standardSizeTable;
@property (nonatomic, copy)   SizeChartClickAction closeAction;
@property (nonatomic, copy)   SizeChartClickAction addCartAction;

@property (nonatomic, strong) VVSizeChartViewControllerConfiguration *configuration;

@end

@implementation VVSizeChartViewController

- (instancetype)initWithConfiguration:(VVSizeChartViewControllerConfiguration *)configuration
{
    VVSizeChartViewController *sizeVc = [[VVSizeChartViewController alloc] init];
    sizeVc.configuration = configuration;
    sizeVc.dataArray = configuration.sizeArray;
    sizeVc.addCartAction = configuration.addCart;
    sizeVc.closeAction = configuration.close;
    sizeVc.isOutOfStock = configuration.isOutOfStock;
    sizeVc.standardSizeArray = configuration.standardSizeArray;
    sizeVc.cmsizeArray = configuration.cmSizeArray;
    sizeVc.inchsizeArray = configuration.inchSizeArray;
    sizeVc.standSizeKeyArray = configuration.keyArray;
    sizeVc.themeColor = configuration.themeColor;
    sizeVc.skuDialogBuyText = configuration.skuDialogBuyText;
    sizeVc.tips = configuration.tips;
    [sizeVc setUpViews];
    [sizeVc setUpConstrains];
    [sizeVc _setPresentAndDismiss];
    return sizeVc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.standardSizeArray.count > 0) {
        [self.standardSizeTable loadWithStandardSizeKeyArray:self.standSizeKeyArray SizeList:self.standardSizeArray tip:self.tips];
    } else {
        [_table setDataArray:self.dataArray];
    }
}

- (void)viewDidLayoutSubviews
{
    [_table showScrollIndicators];
}

- (void)setUpViews
{
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.contentView];
    self.contentView.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
    if (self.standardSizeArray.count > 0) {
        [self.contentView addSubview:self.standardSizeTable];
    } else {
        [self.contentView addSubview:self.table];
    }
    if (self.configuration.sourceType != VVSizeChartSourceTypeNoneAddToCartBtn) {
        [self.contentView addSubview:self.addCartButton];
    }
    [self.contentView addSubview:self.headView];
    [self.headView addSubview:self.titleLabel];
    [self.headView addSubview:self.dismissButton];
    
    if (self.configuration.bottomTextColor) {
        [self.addCartButton setTitleColor:self.configuration.bottomTextColor forState:UIControlStateNormal];
    }
}

- (void)setUpConstrains
{
    __block CGFloat standSizeHeight, sizeHeight;
    [self.standardSizeArray.firstObject.attr_value enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        standSizeHeight += 40;
    }];
    if (standSizeHeight > 171) {
        standSizeHeight = 366;
    } else {
        standSizeHeight = 171;
    }
    [self.dataArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        sizeHeight += 40;
        VVSizeListModel *model = (VVSizeListModel *)obj;
        if (model.attr_value.count) {
            sizeHeight += model.attr_value.count * 40;
        }
    }];
    if (sizeHeight > 171) {
        sizeHeight = 366;
    } else {
        sizeHeight = 171;
    }
    CGFloat maxHeight = standSizeHeight > sizeHeight ? standSizeHeight : sizeHeight;
    self.contextHeight = maxHeight + 54 + 80 + BottomSafeAreaHeight;
    CGFloat moreHeight = 0;
    if (self.configuration.sourceType == VVSizeChartSourceTypeNoneAddToCartBtn) {
        moreHeight = 60;
    }
    if (self.standardSizeArray.count > 0) {
        self.standardSizeTable.frame = CGRectMake(0, 0, SCREEN_W, maxHeight + 54 + moreHeight);
    } else {
        self.table.frame = CGRectMake(0, 0, SCREEN_W, maxHeight + 54 + moreHeight);
    }
    self.contentView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, self.contextHeight);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).offset(5);
        make.centerX.equalTo(self.headView.mas_centerX);
        make.height.mas_equalTo(44);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_H-self.contextHeight);
    }];
    
    [_dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView).offset(5);
        make.trailing.equalTo(self.headView.mas_trailing).with.offset(-4);
        make.height.width.mas_equalTo(44);
    }];
    
    if (self.configuration.sourceType == VVSizeChartSourceTypeNoneAddToCartBtn) {
        return;
    }
    [_addCartButton setFrame:CGRectMake(0, self.contextHeight-52 - BottomSafeAreaHeight, SCREEN_W, 52)];
    if (self.themeColor) {
        [_addCartButton setBackgroundColor:self.isOutOfStock ? kVovaDisabledColor : self.themeColor];
    } else {
        CAGradientLayer *layer = [[CAGradientLayer alloc] init];
        layer.frame = _addCartButton.bounds;
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1.0, 0);
        layer.colors = @[(id)[UIColor colorWithHex:0xfea242].CGColor, (id)[UIColor colorWithHex:0xfd7d11].CGColor];
        [_addCartButton.layer insertSublayer:layer atIndex:0];
    }
    [self setUpConfirmButton];
}

- (void)setUpConfirmButton
{
    if (_configuration.detailType == VVProductDetailViewTypeUpComing) {
        [VVProductDetailUpComingRemindHelp setUpComingConfirmButton:_addCartButton
                                                           reminded:_configuration.reminded
                                                               type:self.configuration.detailType];
    }
}

- (BOOL)allowAutoCheckNetworkStatus
{
    return NO;
}

#pragma mark - private method
- (void)_setPresentAndDismiss
{
    CGFloat duration = 0.5;
    @weakify(self)
    self.presentAndDismissViewModel = [[TDViewControllerPresentAndDismiss alloc] initWithViewController:self duration:duration present:^(TDViewControllerPresentAndDismissCompletionBlock completion) {
        [UIView animateWithDuration:0.25 animations:^{
            @strongify(self);
            self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            self.contentView.mj_y = SCREEN_H - self.contextHeight;
        } completion:^(BOOL finished) {
            completion();
        }];
    } dismiss:^(TDViewControllerPresentAndDismissCompletionBlock completion) {
        [UIView animateWithDuration:0.25 animations:^{
            @strongify(self);
            self.view.backgroundColor = [UIColor clearColor];
            self.contentView.alpha = 0;
            self.contentView.mj_y = SCREEN_H;
        } completion:^(BOOL finished) {
            completion();
        }];
    }];
}

- (void)_addCartAction
{
    if (_configuration.detailType == VVProductDetailViewTypeUpComing)
    {
        // upcoming 不隐藏当前弹窗
        if (self.addCartAction) {
            self.addCartAction();
        }
    } else {
        @weakify(self);
        [self _dismissCompletion:^{
            @strongify(self);
            if (self.addCartAction) {
                self.addCartAction();
            }
        }];
    }
}

- (void)_closeAction
{
    @weakify(self);
    [self _dismissCompletion:^{
        @strongify(self);
        if (self.closeAction) {
            self.closeAction();
        }
    }];
}

- (void)_dismissCompletion:(void (^__nullable)(void))completion
{
    [self dismissViewControllerAnimated:YES completion:completion];
}

#pragma mark - lazy load

- (VVSizeChartTableView *)table
{
    if (!_table) {
        _table = [[VVSizeChartTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0) isNewGoodsDetail:false];
    }
    return _table;
}

- (VVAdultShoeStandSizeTableView *)standardSizeTable
{
    if (!_standardSizeTable) {
        _standardSizeTable = [[VVAdultShoeStandSizeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 0) isNewGoodsDetail:false];
    }
    return _standardSizeTable;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.userInteractionEnabled = YES;
        @weakify(self);
        [_bgView td_onTap:^(UITapGestureRecognizer *tap) {
            @strongify(self);
            [self _dismissCompletion:^{
                if (self.configuration.sourceType == VVSizeChartSourceTypeNoneAddToCartBtn &&
                    self.closeAction)
                {
                    self.closeAction();
                }
            }];
        }];
    }
    return _bgView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, 0)];
        _contentView.backgroundColor = VVColorWithTheme(theme_normalCellBackgroundColor);
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 54)];
        _headView.backgroundColor = [VVColorWithTheme(theme_normalCellBackgroundColor) colorWithAlphaComponent:0.97];
        _headView.userInteractionEnabled = YES;
    }
    return _headView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont VVWeightBoldFontOfSize:19];
        _titleLabel.textColor = VVColorWithTheme(theme_boldTitleTextColor);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = NSLocalizedStringFromTable(@"SIZE CHART", @"DetailPage", @"");
    }
    return _titleLabel;
}

- (UIButton *)dismissButton
{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setImage:[UIImage imageNamed:@"coponList_close"] forState:UIControlStateNormal];
        [_dismissButton setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
        [_dismissButton addTarget:self action:@selector(_closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (UIButton *)addCartButton
{
    if (!_addCartButton) {
        _addCartButton = [[UIButton alloc] init];
        
        _addCartButton.backgroundColor = (self.isOutOfStock ? kVovaDisabledColor : kVovaColor);
        NSString *buy;
        if (vv_isEmptyStr(self.skuDialogBuyText)) {
            buy = [NSLocalizedStringFromTable(@"page_common_BUY_0917", @"DetailPage", @"") uppercaseString];
        } else {
            buy = self.skuDialogBuyText;
        }
        NSString *title = self.isOutOfStock ? NSLocalizedStringFromTable(@"Out of stock", @"ShoppingCart", @"") : buy;
        [_addCartButton setTitle:title forState:UIControlStateNormal];
        _addCartButton.userInteractionEnabled = !self.isOutOfStock;
        _addCartButton.titleLabel.font = [UIFont VVWeightBoldFontOfSize:15];
        [_addCartButton setTitleColor:[UIColor colorWithHex:0xffffff] forState:UIControlStateNormal];
        [_addCartButton addTarget:self action:@selector(_addCartAction) forControlEvents:UIControlEventTouchUpInside];
        _addCartButton.layer.masksToBounds = YES;
    }
    return _addCartButton;
}

@end
