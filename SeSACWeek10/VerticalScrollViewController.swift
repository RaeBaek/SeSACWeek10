//
//  VerticalScrollViewController.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/21.
//

import UIKit

class VerticalScrollViewController: UIViewController, UIScrollViewDelegate {

    let scrollView = UIScrollView()
    let contentView = UIView()

    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        scrollView.delegate = self
        
        configureHierarchy()
        configureLayout()
        configureContentView()

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        print(scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y >= 100 {
            label.alpha = 0.5
        }
    }

    func configureContentView() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(button)

        imageView.backgroundColor = .systemOrange
        label.backgroundColor = .systemYellow
        button.backgroundColor = .systemMint

        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView).inset(10)
            $0.height.equalTo(200)
        }

        button.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(contentView).inset(10)
            $0.height.equalTo(80)
        }

        label.text = "313214/n\n214\n214\n213231\nsbh/njdb\nsj/nhdbsj\nhdv/nsja/ndjhsa\n\ndsa/nhdbs/nhjdb\n\nsak/ndjsa\nk\n3\n32\n1421421/n42\n1\n3\n231\ns/nb\n/nh\njd/nbs/n\njhdb\n/nsjh/ndvsja\ndj/nhs\na\nds/nahdbshjdbsakdjsak"
        label.numberOfLines = 0
        label.textColor = .white
        label.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView)
            $0.top.equalTo(imageView.snp.bottom).offset(50)
            $0.bottom.equalTo(button.snp.top).offset(-50)
        }
    }

    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

    }

    func configureLayout() {
        scrollView.bounces = true
        scrollView.backgroundColor = .systemBackground
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.backgroundColor = .systemGreen
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
    }

}
