//
//  ContactViewModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import Alamofire
import Foundation

class ContactViewModel: ObservableObject {
    @Published var name = ""
    @Published var content = ""
    @Published var prompt = ""
    @Published var contact: [ContactModel] = []
    @Published var errorMessage: String?
    @Published var imageUrl: String = ""
    let serverUrl = ServerUrl.shared
    
    private var accessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    func fetchContacts() {
        let url = serverUrl.getUrl(for: "/contacts")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(
            "https://scenario-api.euns.dev/contacts",
            method: .get,
            encoding: JSONEncoding.default,
            headers : header
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ContactResponse.self) { response in
            switch response.result {
            case.success(let result):
                print("연락처가져오기성공")
                self.contact = result.data
            case.failure(let error):
                print(error)
            }
        }
    }
}

