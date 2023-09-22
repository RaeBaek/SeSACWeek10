//
//  Network.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    // MARK: Router
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completionHandler: @escaping (Result<T, SeSACError>) -> Void) {
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
    }
    
    // MARK: SeSACAPI
    func request<T: Decodable>(type: T.Type, api: SeSACAPI, completionHandler: @escaping (Result<T, SeSACError>) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
    }
}
