//
//  NetworkBasic.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/19.
//

import UIKit
import Alamofire

final class NetworkBasic {
    
    static let shared = NetworkBasic()
    
    private init() { }
    
  //func request(query: String, completionHandler: @escaping (Photo?, Error?) -> Void)
    func request(api: SeSACAPI, completionHandler: @escaping (Result<Photo, SeSACError>) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.query, encoding: URLEncoding(destination: .queryString), headers: api.header).responseDecodable(of: Photo.self) { response in
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
    
    func random(api: SeSACAPI, completionHandler: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        AF.request(api.endpoint, method: api.method, headers: api.header).responseDecodable(of: PhotoResult.self) { response in
            switch response.result {
            case .success(let data): completionHandler(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
    }
    
    func detailPhoto(api: SeSACAPI, completionHandler: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
        AF.request(api.endpoint, method: api.method, headers: api.header).responseDecodable(of: PhotoResult.self) { response in
            switch response.result {
            case .success(let data): completionHandler(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let error = SeSACError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
    }
}
