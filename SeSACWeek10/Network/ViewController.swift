//
//  ViewController.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/19.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.shared.request(type: Photo.self, api: .search(query: "apple")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
        
        Network.shared.request(type: PhotoResult.self, api: .photo(id: "CwnPmtA2NHc")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
}
