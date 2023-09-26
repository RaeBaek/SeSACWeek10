//
//  SearchViewController.swift
//  SeSACWeek10
//
//  Created by 백래훈 on 2023/09/21.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var list = ["이모티콘", "새싹", "추석", "햄버거", "컬렉션뷰레이아웃", "고래밥"]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTagLayout())
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        configureHierarchy()
        configureLayout()
        
        configureDataSource()
        
        let bar = UISearchBar()
        bar.delegate = self
        navigationItem.titleView = bar
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Network.shared.requestConvertible(type: Photo.self, api: .search(query: searchBar.text!)) { response in
            switch response {
            case .success(let success):
                // 데이터 + UI 스냅샷
                let ratios = success.results.map { Ratio(ratio: $0.width / $0.height) }
                
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self.view.frame.width)
                
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                self.configureSnapshot(success)
                
                dump(success)
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func configureSnapshot(_ item: Photo) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(item.results)
        
        dataSource.apply(snapshot)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, PhotoResult> { cell, indexPath, itemIdentifier in
            
            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.urls.thumb))
            cell.label.text = "\(itemIdentifier.created_at)번"
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // 가로는 1/2 세로는 유동적인 느낌
    // 인스타 돋보기 느낌!
    func configurePinterestLayout() -> UICollectionViewLayout {
        // .fractionalWidth, .absolute, .estimated
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        
        // 그룹내의 아이템을 수평으로? 수직으로? 채울지에 대한 메서드 (.horizontal, .vertical)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
//        let group2 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: <#T##Int#>)
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section) // UICollectionViewLayout을 상속 받기에 문제는 없다.
        layout.configuration = configuration
        
        return layout
    }
    
    static func configureTagLayout() -> UICollectionViewLayout {
        // .fractionalWidth, .absolute, .estimated
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30))
        
        // 그룹내의 아이템을 수평으로? 수직으로? 채울지에 대한 메서드 (.horizontal, .vertical)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
//        let group2 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: <#T##Int#>)
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section) // UICollectionViewLayout을 상속 받기에 문제는 없다.
        layout.configuration = configuration
        
        return layout
    }
    
    // 모기 행동요령을 아래의 방법을 이용하여 잘 구현해보자
    // CollectionView Section
    static func configureCollectionVerticalLayout() -> UICollectionViewLayout {
        // .fractionalWidth, .absolute, .estimated
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30))
        
        // 그룹내의 아이템을 수평으로? 수직으로? 채울지에 대한 메서드 (.horizontal, .vertical)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
//        let group2 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: <#T##Int#>)
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section) // UICollectionViewLayout을 상속 받기에 문제는 없다.
        layout.configuration = configuration
        
        return layout
    }
    
    // 모기 행동요령을 아래의 방법을 이용하여 잘 구현해보자
    // CollectionView Section
    static func configureCollectionHorizontalLayout() -> UICollectionViewLayout {
        // .fractionalWidth, .absolute, .estimated
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        
        // 그룹내의 아이템을 수평으로? 수직으로? 채울지에 대한 메서드 (.horizontal, .vertical)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
//        let group2 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: <#T##Int#>)
        
        group.interItemSpacing = .fixed(30)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        section.interGroupSpacing = 50
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(section: section) // UICollectionViewLayout을 상속 받기에 문제는 없다.
        layout.configuration = configuration
        
        return layout
    }
    
//    static func configureCollectionLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.scrollDirection = .vertical
//        return layout
//    }
    
}

extension SearchViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }

        cell.label.text = "\(list[indexPath.row])번"

        return cell
    }
    
    
}
