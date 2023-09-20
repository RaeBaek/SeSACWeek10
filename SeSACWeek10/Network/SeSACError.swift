//
//  SeSACError.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/19.
//

import Foundation

enum SeSACError: Int, Error, LocalizedError {
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "인증 정보가 없습니다."
        case .permissionDenied:
            return "권한이 없습니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요."
        }
    }
}
