//
// Created by Bruno Wernimont on 2012
// Copyright 2012 BaseKit
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "BKCellMapper.h"

#import "BKCellMapping.h"
#import "BKCellAttributeMapping.h"
#import "BKDynamicCellMapping.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface BKCellMapper ()

+ (void)mapLabelAttributeOfTypeDefaultWithObject:(id)object
                                attributeMapping:(BKCellAttributeMapping *)attributeMapping
                                            cell:(UITableViewCell *)cell;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BKCellMapper

@synthesize cellMapping = _cellMapping;
@synthesize object = _object;
@synthesize cell = _cell;


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_cellMapping release];
    [_cell release];
    
    [super dealloc];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSSet *)cellMappingsForObject:(id)object mappings:(NSDictionary *)mappings {
    NSString *objectStringName = NSStringFromClass([object class]);
    return [mappings objectForKey:objectStringName];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (BKCellMapping *)cellMappingForObject:(id)object mappings:(NSSet *)mappings {
    __block BKCellMapping *cellMappingForObject = [mappings anyObject];
    BOOL isDynamicMapping = mappings.count > 1;
    
    if (isDynamicMapping) {
        [mappings enumerateObjectsUsingBlock:^(id cellMapping, BOOL *stop) {
            if ([cellMapping isKindOfClass:[BKDynamicCellMapping class]]) {
                NSString *dynamicKeyPath = [[cellMapping dynamicKeyPath] description];
                NSString *dynamicKeyPathValue = [cellMapping keyPathEqualTo];
                
                if ([[object valueForKeyPath:dynamicKeyPath] isEqualToString:dynamicKeyPathValue]) {
                    cellMappingForObject = cellMapping;
                }
            }
        }];
    }
    
    return cellMappingForObject;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)mapCellAttributeWithMapping:(BKCellMapping *)cellMapping
                             object:(id)object
                               cell:(UITableViewCell *)cell {

    [cellMapping.attributeMappings enumerateKeysAndObjectsUsingBlock:^(id key, BKCellAttributeMapping *cellAttributeMapping, BOOL *stop) {
        if (cellAttributeMapping.mappingType == BKCellAttributeMappingTypeDefault) {
            [self mapLabelAttributeOfTypeDefaultWithObject:object
                                          attributeMapping:cellAttributeMapping
                                                      cell:cell];
        }
    }];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)mapSourceValue:(id)sourceValue toDestinationValue:(id)destinationValue fromCell:(UITableViewCell *)cell {
}


////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)mapLabelAttributeOfTypeDefaultWithObject:(id)object
                                attributeMapping:(BKCellAttributeMapping *)attributeMapping
                                            cell:(UITableViewCell *)cell {
    
    //NSArray *attributeKeyPaths = [attributeMapping.attribute componentsSeparatedByString:@"."];
    //NSString *attributeUIPropertyKey = [attributeKeyPaths firstObject];
    //NSString *attributePropertyKey = [attributeKeyPaths objectAtIndex:1];
    
    id keyPathValue = [object valueForKeyPath:attributeMapping.keyPath];
    //id attributeUIProperty = [cell valueForKeyPath:attributeUIPropertyKey];
    //id attributeProperty = [cell valueForKeyPath:attributePropertyKey];
    
    /*NSAssert(keyPathValue, @"%@ object doesn't respond to %@",
             NSStringFromClass([object class]), attributeMapping.keyPath);
    
    NSAssert(attributeProperty, @"The cell %@ doesn't respond to keyPath %@",
             NSStringFromClass([cell class]), attributeMapping.attribute);*/
    
    if (attributeMapping.valueBlock != nil) {
        keyPathValue = attributeMapping.valueBlock(keyPathValue);
    }
    
    id cellValue = nil;
    
    // Check if source is same as receiver
    /*if ([keyPathValue class] == [attributeProperty class]) {
        cellValue = keyPathValue;
    } else { // Temp, next try to guess destination type
        cellValue = keyPathValue;
    }*/
    
    cellValue = keyPathValue;
    
    [cell setValue:cellValue forKeyPath:attributeMapping.attribute];
}

@end
