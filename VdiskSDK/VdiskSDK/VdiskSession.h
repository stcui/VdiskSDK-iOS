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

#import "VdiskAuthorize.h"
#import "VdiskKeychain.h"
#import "VdiskSDKGlobal.h"
#import "VdiskUtil.h"
#import "VdiskRestClient.h"
#import "SinaWeiboConstants.h"
#import "SinaWeibo.h"


typedef enum {
    
    kVdiskSessionTypeDefault = 0,
	kVdiskSessionTypeWeiboAccessToken,
    
} VdiskSessionType;


@class VdiskSession, VdiskRestClient;


@protocol VdiskSessionDelegate <NSObject>

@optional

// If you try to log in with logIn or logInUsingUserID method, and
// there is already some authorization info in the Keychain,
// this method will be invoked.
// You may or may not be allowed to continue your authorization,
// which depends on the value of isUserExclusive.
- (void)sessionAlreadyLinked:(VdiskSession *)session;
// Log in successfully.
- (void)sessionLinkedSuccess:(VdiskSession *)session;
// Failed to log in.
// Possible reasons are:
// 1) Either username or password is wrong;
// 2) Your app has not been authorized by Sina yet.
- (void)session:(VdiskSession *)session didFailToLinkWithError:(NSError *)error;
// Log out successfully.
- (void)sessionUnlinkedSuccess:(VdiskSession *)session;
// When you use the VdiskSession's request methods,
// you may receive the following four callbacks.
- (void)sessionNotLink:(VdiskSession *)session;
- (void)sessionExpired:(VdiskSession *)session;
- (void)sessionLinkDidCancel:(VdiskSession *)session;

//- (void)sessionWeiboAccessTokenIsNull:(VdiskSession *)session;

@end



@interface VdiskSession : NSObject <VdiskAuthorizeDelegate> {
}


@property (nonatomic, strong) NSString *udid;
@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *appSecret;
@property (nonatomic, strong) NSString *sinaUserID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *appRoot;
@property (nonatomic, assign) NSTimeInterval expireTime;
@property (nonatomic, strong) NSString *redirectURI;
@property (nonatomic, assign) BOOL isUserExclusive;
@property (nonatomic, readonly) VdiskSessionType sessionType;
@property (nonatomic, strong) VdiskAuthorize *authorize;
@property (nonatomic, strong) SinaWeibo *sinaWeibo;
@property (nonatomic, vdisk_weak) id<VdiskSessionDelegate> delegate;
@property (nonatomic, strong) VdiskRestClient *restClient;

// Initialize an instance with the AppKey and the AppSecret you have for your client.
- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret appRoot:(NSString *)appRoot;
- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecret appRoot:(NSString *)appRoot sinaWeibo:(SinaWeibo *)sinaWeibo;

// Log in using OAuth Web authorization.
// If succeed, engineDidLogIn will be called.
- (void)link;
- (void)linkWithSessionType:(VdiskSessionType)sessionType;

- (void)linkUsingWeiboAccessToken:(NSString *)accessToken userID:(NSString *)userID expireTime:(NSTimeInterval)expireTime refreshToken:(NSString *)refreshToken;

//user refreshToken
- (void)refreshLink;
// Log in using OAuth Client authorization.
// If succeed, engineDidLogIn will be called.
- (void)linkUsingUsername:(NSString *)username password:(NSString *)password __attribute__((deprecated));
// Log out.
// If succeed, engineDidLogOut will be called.
- (void)unlink;
// Check if user has logged in, or the authorization is expired.
- (BOOL)isLinked;
- (BOOL)isExpired;

/*
- (void)enabledExternalWeiboAccessToken;
- (void)enabledAndSetExternalWeiboAccessToken:(NSString *)weiboAccessToken;
- (void)disabledExternalWeiboAccessToken;
 */

- (NSDictionary *)requestHeadersWithAuthorization;

+ (NSString *)userAgent;
+ (VdiskSession *)sharedSession;
+ (void)setSharedSession:(VdiskSession *)session;


@end
