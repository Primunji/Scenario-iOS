//
//  SignInViewModel.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import Foundation
import Alamofire

class SignInViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isSecure: Bool = true
    @Published var isLoading: Bool = false
    @Published var loginerrorMessage: String?
    let serverUrl = ServerUrl.shared
    
    var isLoginDisabled: Bool {
        username.isEmpty || password.isEmpty || isLoading
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        
        DispatchQueue.main.async {
            print("토큰 만료 -> 로그인 필요")
        }
    }
    
    
    func login(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let url = serverUrl.getUrl(for: "/auth/login")
        let params = SignInModel(
            username: username,
            password: password
        )
        
        AF.request(
            url,
            method: .post,
            parameters: params,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: TokenResponse.self) { response in
            DispatchQueue.main.async {
                self.isLoading = false
                switch response.result {
                case .success(let tokenResponse):
                    print("로그인 성공")
                    UserDefaults.standard.setValue(tokenResponse.data.accessToken, forKey: "accessToken")
                    UserDefaults.standard.setValue(tokenResponse.data.refreshToken, forKey: "refreshToken")
                    completion(true)
                case .failure(let error):
                    self.loginerrorMessage = error.localizedDescription
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
}

