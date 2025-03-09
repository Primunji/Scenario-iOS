//
//  ScenarioViewModel.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/8/25.
//

import Foundation
import Alamofire
import UIKit

//class ScenarioViewModel: ObservableObject {
//    @Published var name = ""
//    @Published var content = ""
//    @Published var prompt = ""
//    @Published var scenario: [ScenarioModel] = []
//    @Published var errorMessage: String?
//    @Published var imageUrl: String?
//
//    
//    
//    let serverUrl = ServerUrl.shared
//    
//    private var accessToken: String {
//        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
//    }
//    
//    func fetchRecent() {
//        let url = serverUrl.getUrl(for: "/recent")
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(accessToken)"
//        ]
//        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: ScenarioResponse.self) { response in
//                if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
//                    print("서버 응답: \(rawResponse)")
//                }
//                switch response.result {
//                case .success(let scenarioResponse):
//                    print("시나리오 가져오기 성공")
//                    DispatchQueue.main.async {
//                        self.scenario = scenarioResponse.data
//                    }
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        self.errorMessage = "오류 발생: \(error.localizedDescription)"
//                        print(self.accessToken)
//                    }
//                    print("오류: \(error.localizedDescription)")
//                    
//                }
//            }
//    }
//    
//    func fetchScenario() {
//        let url = serverUrl.getUrl(for: "/scenario")
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(accessToken)"
//        ]
//        AF.request("https://scenario-api.euns.dev/scenario", method: .get, encoding: JSONEncoding.default, headers: header)
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: ScenarioResponse.self) { response in
//                if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
//                    print("서버 응답: \(rawResponse)")
//                }
//                switch response.result {
//                case .success(let scenarioResponse):
//                    print("시나리오 가져오기 성공")
//                    DispatchQueue.main.async {
//                        self.scenario = scenarioResponse.data
//                    }
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        self.errorMessage = "오류 발생: \(error.localizedDescription)"
//                        print(self.accessToken)
//                    }
//                    print("오류: \(error.localizedDescription)")
//                    
//                }
//            }
//    }
//    
//    func uploadImage(_ image: UIImage, completion: @escaping (Bool) -> Void) {
//        let url = serverUrl.getUrl(for: "/scenario/upload-profile")
//        
//        let header: HTTPHeaders = [
//            "Authorization": "Bearer \(accessToken)",
//            "Content-Type":"multipart/form-data"
//        ]
//        
//        AF.upload(multipartFormData: { formData in
//            if let imageData = image.jpegData(compressionQuality: 0.8) {
//                formData.append(imageData, withName: "image", fileName: "file.jpg", mimeType: "image/jpeg")
//            }
//        }, to: url, method: .post, headers: header)
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: UploadResponse.self) { response in
//            switch response.result {
//            case .success(let uploadResponse):
//                print("이미지 업로드 성공: \(uploadResponse.message)")
//                DispatchQueue.main.async {
//                    self.scenario.first?.profile_url = uploadResponse.message
//                }
//                completion(true)
//            case .failure(let error):
//                print("이미지 업로드 실패: \(error.localizedDescription)")
//                print("응답 상태 코드: \(response.response?.statusCode ?? 0)")
//                print("응답 데이터: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "없음")")
//                DispatchQueue.main.async {
//                    self.errorMessage = "이미지 업로드 실패: \(error.localizedDescription)"
//                }
//                completion(false)
//            }
//        }
//    }
//    
//    func addContacts(scenarioId: Int64,completion: @escaping (Result<String, Error>) -> Void) {
//        let url = serverUrl.getUrl(for: "/contacts")
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(accessToken)"
//        ]
//        let parameters: [String: Any] = [
//            "scenario_id": scenarioId
//        ]
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
//            .validate(statusCode: 200..<300)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    if let json = value as? [String: Any], let message = json["message"] as? String {
//                        completion(.success(message))
//                    } else {
//                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "응답 포맷 오류"])))
//                    }
//                case .failure(let error):
//                    if let httpResponse = response.response {
//                        print("오류 발생 - 응답 코드:", httpResponse.statusCode)
//                        if let data = response.data,
//                           let responseString = String(data: data, encoding: .utf8) {
//                            print("서버 응답 메시지:", responseString)
//                        }
//                    }
//                    completion(.failure(error))
//                }
//            }
//    }
//    
//    
//    func postScenario(completion: @escaping (Bool) -> Void) {
//        let url = serverUrl.getUrl(for: "/scenario")
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(accessToken)"
//        ]
//        
//        let parameters: [String: Any] = [
//            "name": name,
//            "content": content,
//            "prompt": prompt,
//            "imageUrl": imageUrl ?? ""
//        ]
//        
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
//            .validate(statusCode: 200..<300)
//            .response { response in
//                switch response.result {
//                case .success:
//                    print("시나리오 등록 성공")
//                    DispatchQueue.main.async {
//                        self.fetchScenario()
//                    }
//                    completion(true)
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        self.errorMessage = "오류 발생: \(error.localizedDescription)"
//                    }
//                    print("요청 실패: \(error.localizedDescription)")
//                    
//                    if let httpResponse = response.response {
//                        print("응답 코드: \(httpResponse.statusCode)")
//                    }
//                    completion(false)
//                }
//            }
//    }
//    
//}
//
//struct UploadResponse: Decodable {
//    var status: Int
//    var state: String
//    var message: String
//}
//
//struct IdResponse: Decodable {
//    var scenario_id : Int
//}

class ScenarioViewModel: ObservableObject {
    @Published var name = ""
    @Published var content = ""
    @Published var prompt = ""
    @Published var scenario: [ScenarioModel] = []
    @Published var errorMessage: String?
    @Published var imageUrl: String = ""
    
    let serverUrl = ServerUrl.shared
    
    private var accessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    func fetchRecent() {
        let url = serverUrl.getUrl(for: "/recent")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ScenarioResponse.self) { response in
                if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(rawResponse)")
                }
                switch response.result {
                case .success(let scenarioResponse):
                    print("시나리오 가져오기 성공")
                    DispatchQueue.main.async {
                        self.scenario = scenarioResponse.data
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "오류 발생: \(error.localizedDescription)"
                        print(self.accessToken)
                    }
                    print("오류: \(error.localizedDescription)")
                    
                }
            }
    }
    
    func fetchScenario() {
        let url = serverUrl.getUrl(for: "/scenario")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request("https://scenario-api.euns.dev/scenario", method: .get, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ScenarioResponse.self) { response in
                if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                    print("서버 응답: \(rawResponse)")
                }
                switch response.result {
                case .success(let scenarioResponse):
                    print("시나리오 가져오기 성공")
                    DispatchQueue.main.async {
                        self.scenario = scenarioResponse.data
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "오류 발생: \(error.localizedDescription)"
                        print(self.accessToken)
                    }
                    print("오류: \(error.localizedDescription)")
                    
                }
            }
    }

    func uploadImage(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        let url = serverUrl.getUrl(for: "/scenario/upload-profile")
        
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type":"multipart/form-data"
        ]
    
        let parameters: [String: Any] = [
            "name": name,
            "content": content,
            "prompt": prompt,
            "imageUrl": imageUrl.isEmpty ? nil : imageUrl
        ]
        
        AF.upload(multipartFormData: { formData in
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                formData.append(imageData, withName: "image", fileName: "file.jpg", mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UploadResponse.self) { response in
            switch response.result {
            case .success(let uploadResponse):
                print("이미지 업로드 성공: \(uploadResponse.message)")
                DispatchQueue.main.async {
                    if self.scenario.count > 0 {
                        self.scenario[0].profile_url = uploadResponse.message
                    }
                }
                completion(true)
            case .failure(let error):
                print("이미지 업로드 실패: \(error.localizedDescription)")
                print("응답 상태 코드: \(response.response?.statusCode ?? 0)")
                print("응답 데이터: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "없음")")
                DispatchQueue.main.async {
                    self.errorMessage = "이미지 업로드 실패: \(error.localizedDescription)"
                }
                completion(false)
            }
        }
    }
    
     func postScenarioIdToContacts(scenarioId: Int) {
        let url = serverUrl.getUrl(for: "/contacts")
        
        let parameters: [String: Any] = [
            "scenario_id": scenarioId
        ]
        
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("scenario.id 전송 성공")
                case .failure(let error):
                    print("scenario.id 전송 실패: \(error.localizedDescription)")
                }
            }
    }
    
    func addContacts(scenarioId: Int64,completion: @escaping (Result<String, Error>) -> Void) {
        let url = serverUrl.getUrl(for: "/contacts")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        let parameters: [String: Any] = [
            "scenario_id": scenarioId
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any], let message = json["message"] as? String {
                        completion(.success(message))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "응답 포맷 오류"])))
                    }
                case .failure(let error):
                    if let httpResponse = response.response {
                        print("오류 발생 - 응답 코드:", httpResponse.statusCode)
                        if let data = response.data,
                           let responseString = String(data: data, encoding: .utf8) {
                            print("서버 응답 메시지:", responseString)
                        }
                    }
                    completion(.failure(error))
                }
            }
    }
    
    
    func postScenario(completion: @escaping (Bool) -> Void) {
        let url = serverUrl.getUrl(for: "/scenario")
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        let parameters: [String: Any] = [
            "name": name,
            "content": content,
            "prompt": prompt,
            "imageUrl": imageUrl ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("시나리오 등록 성공")
                    DispatchQueue.main.async {
                        self.fetchScenario()
                    }
                    completion(true)
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "오류 발생: \(error.localizedDescription)"
                    }
                    print("요청 실패: \(error.localizedDescription)")
                    
                    if let httpResponse = response.response {
                        print("응답 코드: \(httpResponse.statusCode)")
                    }
                    completion(false)
                }
            }
    }

    struct UploadResponse: Decodable {
        var status: Int
        var state: String
        var message: String
    }
}
