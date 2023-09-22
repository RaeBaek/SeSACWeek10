//
//  Constant.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/22.
//

import UIKit

// 다크모드 관련 열거형!
// 그냥 Constant안에 모든 컬러의 케이스를 넣는다면 수가 많아졌을 상황에 찾기 어려울 것이다. 한 뎁스 더 들어가자.
enum Constant {
    
    // 텍스트와 연관된 컬러이다.
    enum Text {
        static let title = UIColor(named: "title")!
    }
    
    // 이미지와 연관된 컬러이다.
    enum Image {
        static let star = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal).withTintColor(Constant.Text.title)
    }
    
    
    
    
}
