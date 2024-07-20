//
//  TravelViewController.swift
//  modern-collectionview-practice
//
//  Created by junehee on 7/20/24.
//

import UIKit

struct Talk: Hashable, Identifiable {
    let id = UUID()
    let profileImage: String
    let name: String
    let message: String
    let date: String
}

final class TalkViewController: UIViewController {
    
    enum Section: CaseIterable {
        case all
    }
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .white
        config.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Talk>!
    
    private let talkList = [
        Talk(profileImage: "01", name: "Hue", message: "왜요? 요즘 코딩이 대세인데", date: "24.01.12"),
        Talk(profileImage: "02", name: "Jack", message: "깃허브 푸시하셨나여?", date: "24.01.12"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
        configureDataSource()
        updateSnapShot()
    }
    
    private func setViewController() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        navigationItem.title = "TRAVEL TALK"
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(44)
        }
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "친구 이름을 검색해 보세요~!"
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource() {
        var registraiton: UICollectionView.CellRegistration<UICollectionViewListCell, Talk>!
        registraiton = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.image = UIImage(named: itemIdentifier.profileImage)
            content.imageProperties.reservedLayoutSize = CGSize(width: 50, height: 50)
            
            content.text = itemIdentifier.name
            content.textProperties.font = .boldSystemFont(ofSize: 16)
            
            // 날짜 위치
//            content.secondaryText = itemIdentifier.date
//            content.secondaryTextProperties.font = .systemFont(ofSize: 12, weight: .light)
            
            // 메세지 위치
            content.secondaryText = itemIdentifier.message
            content.secondaryTextProperties.font = .systemFont(ofSize: 12, weight: .light)
            content.prefersSideBySideTextAndSecondaryText = false // SecondaryText 위치 변경
            
            cell.contentConfiguration = content
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registraiton, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Talk>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(talkList, toSection: .all)
        dataSource.apply(snapShot)
    }
    
}
