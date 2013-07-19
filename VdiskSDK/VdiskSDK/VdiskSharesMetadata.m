//
//  VdiskSharesMetadata.m
//  VdiskSDK
//
//  Created by Bruce on 12-12-20.
//
//

#import "VdiskSharesMetadata.h"

@implementation VdiskSharesMetadata

@synthesize appKey = _appKey;
@synthesize uid = _uid;
@synthesize sinaUid = _sinaUid;
@synthesize name = _name;
@synthesize cpRef = _cpRef;
@synthesize link = _link;
@synthesize url = _url;
@synthesize shareTime = _shareTime;

@synthesize countBrowse = _countBrowse;
@synthesize countDownload = _countDownload;
@synthesize countCopy = _countCopy;
@synthesize countLike = _countLike;

@synthesize webHot = _webHot;
@synthesize iosHot = _iosHot;
@synthesize androidHot = _androidHot;
@synthesize isPreview = _isPreview;
@synthesize isStream = _isStream;

@synthesize categoryId = _categoryId;
@synthesize shareId = _shareId;
@synthesize title = _title;
@synthesize descriptions = _descriptions;
@synthesize shareType = _shareType;
@synthesize nick = _nick;
@synthesize price = _price;
@synthesize degree = _degree;
@synthesize shareAuth = _shareAuth;
@synthesize thumbnail = _thumbnail;


- (id)initWithDictionary:(NSDictionary *)dict {
    
    if ((self = [super initWithDictionary:dict])) {
        
        @try {
            
            
            if ([dict objectForKey:@"share_time"]) {
                
                _shareTime = [[VdiskSharesMetadata dateFormatter] dateFromString:[dict objectForKey:@"share_time"]];
            }
            
            if ([dict objectForKey:@"contents"]) {
                
                NSArray *subfileDicts = [dict objectForKey:@"contents"];
                NSMutableArray *mutableContents = [[NSMutableArray alloc] initWithCapacity:[subfileDicts count]];
                
                for (NSDictionary *subfileDict in subfileDicts) {
                    
                    VdiskSharesMetadata *subfile = [[VdiskSharesMetadata alloc] initWithDictionary:subfileDict];
                    [mutableContents addObject:subfile];
                }
                
                _contents = nil;
                _contents = mutableContents;
            }
            
            /*
             
             app_key: "123456",
             uid: "371811",
             sina_uid: "1860293774",
             name: "【店铺设计】页面让客户一“见”钟情之首页设计.zip",
             copy_ref: "fQJvH",
             link: "",
             url: "",
             share_time: "Tue, 16 Oct 2012 09:48:12 +0000",
             
             count_browse: "0",
             count_download: "515",
             count_copy: "147",
             count_like: "0",
             
             web_hot: false,
             ios_hot: false,
             android_hot: false,
             is_preview: false,
             is_stream: false,
             
             category_id: "0",
             share_id: null,
             title: null,
             description: null,
             share_type: null,
             nick: null,
             price: null,
             degree: null,
             share_auth: null
             
             */
            
            
            _webHot = [[dict objectForKey:@"web_hot"] boolValue];
            _iosHot = [[dict objectForKey:@"ios_hot"] boolValue];
            _androidHot = [[dict objectForKey:@"android_hot"] boolValue];
            _isPreview = [[dict objectForKey:@"is_preview"] boolValue];
            _isStream = [[dict objectForKey:@"is_stream"] boolValue];
            
            
            _appKey = [dict objectForKey:@"app_key"];
            _uid = [dict objectForKey:@"uid"];
            _sinaUid = [dict objectForKey:@"sina_uid"];
            _name = [dict objectForKey:@"name"];
            _cpRef = [dict objectForKey:@"copy_ref"];
            _link = [dict objectForKey:@"link"];
            _url = [dict objectForKey:@"url"];
            
            
            _countBrowse = [dict objectForKey:@"count_browse"];
            _countDownload = [dict objectForKey:@"count_download"];
            _countCopy = [dict objectForKey:@"count_copy"];
            _countLike = [dict objectForKey:@"count_like"];
            
            
            _categoryId = [dict objectForKey:@"category_id"];
            _shareId = [dict objectForKey:@"share_id"];
            _title = [dict objectForKey:@"title"];
            _descriptions = [dict objectForKey:@"description"];
            _shareType = [dict objectForKey:@"share_type"];
            _nick = [dict objectForKey:@"nick"];
            _price = [dict objectForKey:@"price"];
            _degree = [dict objectForKey:@"degree"];
            _shareAuth = [dict objectForKey:@"share_auth"];
            
            _thumbnail = [dict objectForKey:@"thumbnail"];
            
        
        } @catch (NSException *exception) {
            
            
            
        } @finally {
            
            
        }
    }
    
    return self;
}


- (NSString *)filename {
    
    return _name;
}

- (BOOL)isEqual:(id)object {
    
    if (object == self) return YES;
    if (![object isKindOfClass:[VdiskSharesMetadata class]]) return NO;
    
    VdiskSharesMetadata *other = (VdiskSharesMetadata *)object;
    
    return [self.fileSha1 isEqual:other.fileSha1] && [self.fileMd5 isEqual:other.fileMd5] && [self.name isEqual:other.name] && [self.cpRef isEqual:other.cpRef];
}

- (NSDictionary *)dictionaryValue {

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[super dictionaryValue]];
    
    if (_title) {
        
        [dictionary setValue:_title forKey:@"title"];
    }
    
    if (_name) {
        
        [dictionary setValue:_name forKey:@"name"];
    }
    
    if (_cpRef) {
        
        [dictionary setValue:_cpRef forKey:@"copy_ref"];
    }
    
    if (_url) {
        
        [dictionary setValue:_url forKey:@"url"];
    }
    
    if (_link) {
        
        [dictionary setValue:_link forKey:@"link"];
    }
    
    if (_uid) {
        
        [dictionary setValue:_uid forKey:@"uid"];
    }
    
    if (_sinaUid) {
        
        [dictionary setValue:_sinaUid forKey:@"sina_uid"];
    }
    
    if (_appKey) {
        
        [dictionary setValue:_appKey forKey:@"app_key"];
    }
    
    if (_thumbnail) {
        
        [dictionary setValue:_thumbnail forKey:@"thumbnail"];
    }
    
    return dictionary;
}

- (BOOL)thumbnailExists {

    if (_thumbnail && [_thumbnail isKindOfClass:[NSString class]] && [_thumbnail length] > 0) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark NSCoding methods

- (id)initWithCoder:(NSCoder *)coder {
    
    if ((self = [super initWithCoder:coder])) {
                
        _webHot = [coder decodeBoolForKey:@"webHot"];
        _iosHot = [coder decodeBoolForKey:@"iosHot"];
        _androidHot = [coder decodeBoolForKey:@"androidHot"];
        _isPreview = [coder decodeBoolForKey:@"isPreview"];
        _isStream = [coder decodeBoolForKey:@"isStream"];
        
        _appKey = [coder decodeObjectForKey:@"appKey"];
        _uid = [coder decodeObjectForKey:@"uid"];
        _sinaUid = [coder decodeObjectForKey:@"sinaUid"];
        _name = [coder decodeObjectForKey:@"name"];
        _cpRef = [coder decodeObjectForKey:@"cpRef"];
        _link = [coder decodeObjectForKey:@"link"];
        _url = [coder decodeObjectForKey:@"url"];
        
        _countBrowse = [coder decodeObjectForKey:@"countBrowse"];
        _countDownload = [coder decodeObjectForKey:@"countDownload"];
        _countCopy = [coder decodeObjectForKey:@"countCopy"];
        _countLike = [coder decodeObjectForKey:@"countLike"];
        
        _categoryId = [coder decodeObjectForKey:@"categoryId"];
        _shareId = [coder decodeObjectForKey:@"shareId"];
        _title = [coder decodeObjectForKey:@"title"];
        _descriptions = [coder decodeObjectForKey:@"descriptions"];
        _shareType = [coder decodeObjectForKey:@"shareType"];
        _nick = [coder decodeObjectForKey:@"nick"];
        _price = [coder decodeObjectForKey:@"price"];
        _degree = [coder decodeObjectForKey:@"degree"];
        _shareAuth = [coder decodeObjectForKey:@"shareAuth"];
        
        _thumbnail = [coder decodeObjectForKey:@"thumbnail"];
    
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {

    [super encodeWithCoder:coder];
    
    
    [coder encodeBool:_webHot forKey:@"webHot"];
    [coder encodeBool:_iosHot forKey:@"iosHot"];
    [coder encodeBool:_androidHot forKey:@"androidHot"];
    [coder encodeBool:_isPreview forKey:@"isPreview"];
    [coder encodeBool:_isStream forKey:@"isStream"];
    
    [coder encodeObject:_appKey forKey:@"appKey"];
    [coder encodeObject:_uid forKey:@"uid"];
    [coder encodeObject:_sinaUid forKey:@"sinaUid"];
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_cpRef forKey:@"cpRef"];
    [coder encodeObject:_link forKey:@"link"];
    [coder encodeObject:_url forKey:@"url"];
    
    [coder encodeObject:_countBrowse forKey:@"countBrowse"];
    [coder encodeObject:_countDownload forKey:@"countDownload"];
    [coder encodeObject:_countCopy forKey:@"countCopy"];
    [coder encodeObject:_countLike forKey:@"countLike"];
    
    [coder encodeObject:_categoryId forKey:@"categoryId"];
    [coder encodeObject:_shareId forKey:@"shareId"];
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_descriptions forKey:@"descriptions"];
    [coder encodeObject:_shareType forKey:@"shareType"];
    [coder encodeObject:_nick forKey:@"nick"];
    [coder encodeObject:_price forKey:@"price"];
    [coder encodeObject:_degree forKey:@"degree"];
    [coder encodeObject:_shareAuth forKey:@"shareAuth"];
    
    [coder encodeObject:_thumbnail forKey:@"thumbnail"];
    
}

@end
