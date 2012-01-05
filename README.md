BKCellMapping is an IOS library that help using table view, he map data from anay object to any cell.

### Setting item objects

    self.items = [NSArray arrayWithObjects:
                  [Item itemWithTitle:@"Movie1" subtitle:@"First movie" type:@"movie"],
                  [Item itemWithTitle:@"Movie2" subtitle:@"Second movie" type:@"movie"],
                  [Item itemWithTitle:@"Book1" subtitle:nil type:@"book"],
                  nil];

### Configure the mapping

    self.tableModel = [BKTableModel tableModelForTableView:self.tableView delegate:self];

    [BKCellMapping mappingForObjectClass:[Item class] block:^(BKCellMapping *cellMapping) {
	    [cellMapping mapKeyPath:@"title" toAttribute:@"textLabel.text"];
	    [cellMapping mapKeyPath:@"subtitle" toAttribute:@"detailTextLabel.text"];
	    [cellMapping mapObjectToCellClass:[BookViewCell class]];
	    [self.tableModel registerMapping:cellMapping];
    }];

### UITableViewDataSource

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.items.count;
	}

	- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)	indexPath {
    		return [self.tableModel cellForRowAtIndexPath:indexPath];
	}

### BKTableModelDataSource

	#pragma mark - BKTableModelDataSource

	- (id)tableModel:(BKTableModel *)tableModel objectForRowAtIndexPAth:(NSIndexPath *)indexPath {
    	return [self.items objectAtIndex:indexPath.row];
	}

That it !
