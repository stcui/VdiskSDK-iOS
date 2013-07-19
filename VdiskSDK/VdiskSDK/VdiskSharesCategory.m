//
//  VdiskSharesCategory.m
//  VdiskSDK
//
//  Created by Bruce on 13-1-15.
//
//

#import "VdiskSharesCategory.h"

@implementation VdiskSharesCategory

@synthesize categoryId = _categoryId;
@synthesize categoryName = _categoryName;
@synthesize categoryPid = _categoryPid;


- (id)initWithDictionary:(NSDictionary *)dict {

    if ((self = [super init])) {
        
        _categoryId = [dict objectForKey:@"category_id"];
        _categoryName = [dict objectForKey:@"category_name"];
        _categoryPid = [dict objectForKey:@"category_pid"];
        
    }
    
    return self;
}


#pragma mark NSCoding methods

- (id)initWithCoder:(NSCoder *)coder {
    
    if ((self = [super init])) {
        
        _categoryId = [coder decodeObjectForKey:@"categoryId"];
        _categoryName = [coder decodeObjectForKey:@"categoryName"];
        _categoryPid = [coder decodeObjectForKey:@"categoryPid"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {

    [coder encodeObject:_categoryId forKey:@"categoryId"];
    [coder encodeObject:_categoryName forKey:@"categoryName"];
    [coder encodeObject:_categoryPid forKey:@"categoryPid"];
}

@end
