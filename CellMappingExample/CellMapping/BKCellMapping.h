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

#import <Foundation/Foundation.h>

#import "BKCellMappingBlocks.h"

@interface BKCellMapping : NSObject

@property (nonatomic, assign) Class objectClass;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, readonly) NSMutableDictionary *attributeMappings;
@property (nonatomic, retain) UINib *nib;

- (id)initWithObjectClass:(Class)objectClass;

+ (id)mappingForObjectClass:(Class)objectClass block:(void(^)(BKCellMapping *cellMapping))block;

- (void)mapKeyPath:(NSString *)keyPath
       toAttribute:(NSString *)attribute
        valueBlock:(BKCellValueBlock)valueBlock;

- (void)mapKeyPath:(NSString *)keyPath toAttribute:(NSString *)attribute;

- (void)mapKeyPath:(NSString *)keyPath
           toLabel:(NSString *)attribute
        valueBlock:(BKCellValueBlock)valueBlock;

- (void)mapObjectToCellClass:(Class)cellClass;

@end
