//
//  VdiskSDK
//  Based on OAuth 2.0
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by Bruce Chen (weibo: @一个开发者) on 12-6-15.
//
//  Copyright (c) 2012 Sina Vdisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "VdiskSDKGlobal.h"

@protocol VdiskRequestDelegate;

@interface VdiskRequest : NSObject <ASIHTTPRequestDelegate> {
    
}

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSDictionary *httpHeaderFields;
@property (nonatomic, vdisk_weak) id<VdiskRequestDelegate> delegate;
@property (nonatomic, strong) ASIFormDataRequest *request;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSString *udid;

+ (VdiskRequest *)requestWithURL:(NSString *)url
                      httpMethod:(NSString *)httpMethod
                          params:(NSDictionary *)params
                httpHeaderFields:(NSDictionary *)httpHeaderFields
                            udid:(NSString *)udid 
                        delegate:(id<VdiskRequestDelegate>)delegate;

+ (VdiskRequest *)requestWithAccessToken:(NSString *)accessToken
                                     url:(NSString *)url
                              httpMethod:(NSString *)httpMethod
                                  params:(NSDictionary *)params
                        httpHeaderFields:(NSDictionary *)httpHeaderFields
                                    udid:(NSString *)udid
                                delegate:(id<VdiskRequestDelegate>)delegate;

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod;
+ (NSString *)stringFromDictionary:(NSDictionary *)dict;

- (void)connect;
- (void)disconnect;
- (void)start;
- (void)cancel;

- (NSUInteger)responseDataLength;
- (ASIFormDataRequest *)finalRequest;


@end




#pragma mark -
#pragma mark - VdiskRequestDelegate

@protocol VdiskRequestDelegate <NSObject>


@optional

- (void)request:(VdiskRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;

- (void)request:(VdiskRequest *)request didReceiveRawData:(NSData *)data;

- (void)request:(VdiskRequest *)request didFailWithError:(NSError *)error;

- (void)request:(VdiskRequest *)request didFinishLoadingWithResult:(id)result;

@end
