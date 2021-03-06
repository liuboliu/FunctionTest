//
//  VVKVOObserver.m
//  vv_rootlib_ios
//
//  Created by JackLee on 2020/6/13.
//

#import "VVKVOObserver.h"
#import "NSObject+Swizzle.h"
#import "VVKVOItem.h"
#import "VVKVOItemManager.h"

@interface VVKVOArrayItem(Private)
@property (nonatomic, weak, nullable, readwrite) __kindof NSObject *observered_property;
@end

@implementation VVKVOArrayItem(Private)
@dynamic observered_property;

@end

@interface VVKVOObserver()

@property (nonatomic, weak, nullable, readwrite) __kindof NSObject *originObserver;
@property (nonatomic, copy, nullable, readwrite) NSString *originObserver_address;

@end

@implementation VVKVOObserver

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [VVKVOObserver class];
        SEL observeValueForKeyPath = @selector(observeValueForKeyPath:ofObject:change:context:);
        SEL vv_ObserveValueForKeyPath = @selector(vvhook_observeValueForKeyPath:ofObject:change:context:);
        [NSObject exchangeInstanceMethod:class originalSel:observeValueForKeyPath swizzledSel:vv_ObserveValueForKeyPath];
    });
}

+ (instancetype)initWithOriginObserver:(__kindof NSObject *)originObserver
{
    VVKVOObserver *kvoObserver = [[self alloc] init];
    if (kvoObserver) {
        kvoObserver.originObserver = originObserver;
        kvoObserver.originObserver_address = [NSString stringWithFormat:@"%p",originObserver];
        kvoObserver.observerCount = 1;
    }
    return kvoObserver;
}

- (void)vvhook_observeValueForKeyPath:(NSString *)keyPath
                             ofObject:(id)object
                               change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                              context:(void *)context
{
    if ([object isKindOfClass:[NSObject class]]) {
        VVKVOItem *item = nil;
        if (self.observerCount > 1) {
            item = [VVKVOItemManager isContainArrayItemWith_kvoObserver:self element_observered:object keyPath:keyPath context:context];
        } else {
            item = [VVKVOItemManager isContainItemWith_kvoObserver:self observered:object keyPath:keyPath context:context];
        }
        if (!item
            || !item.valid) {
            return;
        }
        
        if ([item isKindOfClass:[VVKVOArrayItem class]]) {
            VVKVOArrayItem *arrayItem = (VVKVOArrayItem *)item;
            NSObject *observeredObject = (NSObject *)object;
            if ([arrayItem.observered isEqual:observeredObject]) { // 数组对象指针的变化
                arrayItem.observered_property = [observeredObject valueForKeyPath:keyPath];
                if (arrayItem.observered_property) {
                    NSAssert([arrayItem.observered_property isKindOfClass:[NSArray class]], @"make sure [arrayItem.observered_property isKindOfClass:[NSArray class]] be YES");
                }
                void(^detailBlock)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context) = arrayItem.detailBlock;
                if (detailBlock) {
                    detailBlock(keyPath,change,nil,context);
                }
            } else { // 数组元素对应的属性的变化
                void(^detailBlock)(NSString *keyPath, NSDictionary *change, VVKVOArrayChangeModel *changedModel, void *context) = arrayItem.detailBlock;
                if (detailBlock) {
                    NSArray <VVKVOArrayElement *>*kvoElements = [arrayItem kvoElementsWithElement:observeredObject];
                    VVKVOArrayChangeModel *changedModel = [VVKVOArrayChangeModel new];
                    changedModel.changeType = VVKVOArrayChangeTypeElement;
                    changedModel.changedElements = kvoElements;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    if ((arrayItem.options & NSKeyValueObservingOptionOld) == NSKeyValueObservingOptionOld) {
                        dic[NSKeyValueChangeOldKey] = arrayItem.observered_property;
                    }
                    
                    if ((arrayItem.options & NSKeyValueObservingOptionNew) == NSKeyValueObservingOptionNew) {
                        dic[NSKeyValueChangeNewKey] = arrayItem.observered_property;
                    }
                    detailBlock(arrayItem.keyPath,dic,changedModel,arrayItem.context);
                }
            }
            
        } else {
            void(^block)(NSString *keyPath, NSDictionary *change, void *context) = item.block;
            if (block) {
                block(keyPath,change,context);
            }
        }
        
    }
}
@end
