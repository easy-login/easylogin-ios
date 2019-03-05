//
//  API.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

@objcMembers
public class API: NSObject {
    
    static let shared = API()
    
    private override init() {
    }
     /**
     ?platform=and")
     Call<InitAuthResponse> authorize(@Path("provider") String provider,
     @Query("app_id") String appId,
     @Query("callback_uri") String callbackUri,
     @Query("code_challenge") String codeChallenge);
     */
    func authorize(provider: String?,
                                 appId: String?,
                                 callbackUri: String?,
                                 codeChallenge: String?, completionHandler: @escaping(_ response: InitAuthResponse?, _ error: Error?) -> Void) {
        let request = AuthorizeRequest(provider: provider ?? "", appId: appId ?? "", callbackUri: callbackUri, codeChallenge: codeChallenge)
        call(request: request, completionHandler: completionHandler)
    }
    
    /*
     @FormUrlEncoded
     @POST("/auth/{provider}/verify-token")
     Call<EasyAuthToken> verifyToken(@Path("provider") String provider,
     @Query("access_token") String accessToken,
     @Query("id_token") String idToken,
     @Query("state") String state);
     */
    
    func verifyToken(provider: String, accessToken: String, state: String?,
                     completionHandler: @escaping(_ response: EasyAuthToken?, _ error: Error?) -> Void) {
        let request = VerifyTokenRequest(provider: provider, accessToken: accessToken, state: state)
        call(request: request, completionHandler: completionHandler)
    }
    
    /*@FormUrlEncoded
     @POST("/auth/profles/authorized")
     Call<EasyProfile> getAuthorizedProfile(@Query("auth_token") String authToken,
     @Query("code_verifier") String codeVerifier);*/
    
    func getAuthorizedProfile(appId: String, authToken: String, codeVerifier: String,
                              completionHandler: @escaping(_ response: EasyProfile?, _ error: Error?) -> Void) {
        let request = GetAuthorizeProfileRequest(appId: appId, authToken: authToken, codeVerifier: codeVerifier)
        call(request: request, completionHandler: completionHandler)
    }
    /*@FormUrlEncoded
     @POST("/auth/profles/authorized")
     Call<ResponseBody> activateProfile(@Query("auth_token") String authToken,
     @Query("code_verifier") String codeVerifier);*/
    
    func activateAuthorizedProfile(appId: String, authToken: String, codeVerifier: String,
                              completionHandler: @escaping(_ response: ActivateAuthorizedResponse?, _ error: Error?) -> Void) {
        let request = ActiveAuthorizeProfileRequest(appId: appId, authToken: authToken, codeVerifier: codeVerifier)
        call(request: request, completionHandler: completionHandler)
    }
}


//MARK:- Call and call list base
extension API {
    private func callList<T: ServiceModel>(request: Request, completionHandler: @escaping(_ response: [T]?, _ error: Error?) -> Void) {
        URLSession.shared.requestJSON(with: request) { (data: [T]?, error) in
            if let data = data {
                completionHandler(data, error)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    private func call<T: ServiceModel>(request: Request , completionHandler: @escaping(_ response: T?, _ error: Error?) -> Void) {
        URLSession.shared.requestJSON(with: request) { (data: T?, error) in
            if let data = data {
                completionHandler(data, error)
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
