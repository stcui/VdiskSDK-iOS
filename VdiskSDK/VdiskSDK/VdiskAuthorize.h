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
#import "VdiskSDKGlobal.h"
#import "VdiskRequest.h"
#import "VdiskAuthorizeWebView.h"

@class VdiskAuthorize;

@protocol VdiskAuthorizeDelegate <NSObject>

@required

- (void)authorize:(VdiskAuthorize *)authorize didSucceedWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken userID:(NSString *)userID expiresIn:(NSInteger)seconds;
- (void)authorize:(VdiskAuthorize *)authorize didFailWithError:(NSError *)error;
- (void)authorizeDidCancel:(VdiskAuthorize *)authorize;

@end

@interface VdiskAuthorize : NSObject <
#if TARGET_OS_IPHONE
VdiskAuthorizeWebViewDelegate,
#endif
VdiskRequestDelegate> {
    
    NSString    *_appKey;
    NSString    *_appSecret;
    NSString    *_redirectURI;
    VdiskRequest   *_request;
    id<VdiskAuthorizeDelegate> __vdisk_weak _delegate;
    NSString *_udid;
}

@property (nonatomic, strong) NSString *udid;;
@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *appSecret;
@property (nonatomic, strong) NSString *redirectURI;
@property (nonatomic, strong) VdiskRequest *request;
@property (nonatomic, vdisk_weak) id<VdiskAuthorizeDelegate> delegate;

- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret udid:(NSString *)udid;
- (void)startAuthorize;
- (void)startAuthorizeUsingUsername:(NSString *)username password:(NSString *)password;
- (void)startAuthorizeUsingRefreshToken:(NSString *)refreshToken;

@end
