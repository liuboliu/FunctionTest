//
//  VVCollectionViewCustomLayoutProtocol.h
//  vv_bodylib_ios
//
//  Created by JackLee on 2020/4/24.
//

#ifndef VVCollectionViewCustomLayoutProtocol_h
#define VVCollectionViewCustomLayoutProtocol_h
@protocol VVCollectionCustomLayoutDelegate<NSObject>

@optional

/// 每个区多少列
- (NSInteger)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout columnNumberAtSection:(NSInteger )section;

/// cell size
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/// header size
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

/// footer size
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

/// 每个区的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

/// 每个区内部的垂直距离
- (CGFloat)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

/// 每个区内部的水平距离
- (CGFloat)collectionView:(UICollectionView *)collectionView customLayout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

/// 图层重叠高度
- (CGFloat)overlapHeightAtIndexPath:(NSIndexPath *)indexPath;

/// 装饰视图重叠高度
- (CGFloat)overLapHeightForDocarationViewAtSection:(NSInteger)section;

///使用配置的contentSize，和  customContentSize方法配合使用
/// 这时候使用代理方法配置的contentSize
- (BOOL)useCustomContentSize;

///  配置的contentSize
- (CGSize)customContentSize;
/// 装饰视图的类名数组
- (NSArray <Class>*)decorationViewClasses;
/// 根据indexPath获取装饰视图的类
- (Class)decorationViewClassOfIndexPath:(NSIndexPath *)indexPath;

@end

@protocol VVCollectionViewCustomLayoutProtocol<NSObject,
VVCollectionCustomLayoutDelegate>

@property (nonatomic, weak) id<VVCollectionCustomLayoutDelegate> vv_layoutDelegate;

@end

#endif /* VVCollectionViewCustomLayoutProtocol_h */
