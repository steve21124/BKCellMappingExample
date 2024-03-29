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

#import "BKCellMapping.h"

@interface BKDynamicCellMapping : BKCellMapping

@property (nonatomic, copy) NSString *dynamicKeyPath;
@property (nonatomic, retain) NSString *keyPathEqualTo;

+ (id)mappingForObjectClass:(Class)objectClass block:(void(^)(BKDynamicCellMapping *cellMapping))block;

- (void)mapObjectToCellClass:(Class)cellClass
          whenValueOfKeyPath:(NSString *)valueOfKeyPath
                   isEqualTo:(id)equalTo;

@end
