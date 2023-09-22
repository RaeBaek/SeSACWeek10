//
//  HorizontalScrollViewController.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/21.
//

import UIKit

class HorizontalScrollViewController: UIViewController {

    let scrollView = UIScrollView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureStackView()

    }

    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

    }

    func configureLayout() {
        scrollView.backgroundColor = .lightGray
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }

        stackView.spacing = 16
        stackView.backgroundColor = .black
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(scrollView.snp.height)
        }
    }

    func configureStackView() {
        let label1 = UILabel()
        label1.text = "안녕하세요."
        label1.backgroundColor = .systemYellow
        label1.textColor = .white
        stackView.addArrangedSubview(label1)

        let label2 = UILabel()
        label2.text = "반갑습니다."
        label2.backgroundColor = .systemBlue
        label2.textColor = .white
        stackView.addArrangedSubview(label2)

        let label3 = UILabel()
        label3.text = "안녕히계세요."
        label3.backgroundColor = .systemMint
        label3.textColor = .white
        stackView.addArrangedSubview(label3)

        let label4 = UILabel()
        label4.text = "오늘 점심을 추천해주세요."
        label4.textColor = .white
        stackView.addArrangedSubview(label4)

        let label5 = UILabel()
        label5.text = "잘 지내세요."
        label5.textColor = .white
        stackView.addArrangedSubview(label5)
    }

}
