//
//  ViewController.swift
//  modern-collectionview-practice
//
//  Created by junehee on 7/19/24.
//

import UIKit
import SnapKit

struct Menu: Hashable {
    let title: String
}

final class SettingViewController: UIViewController {
    
    enum SettingSection: CaseIterable {
        case all
        case personal
        case etc
    }
    
    let menuList: [[Menu]] = [
        [Menu(title: "공지사항"), Menu(title: "실험실"), Menu(title: "버전 정보")],
        [Menu(title: "개인/보안"), Menu(title: "알림"), Menu(title: "채팅")],
        [Menu(title: "고객센터/도움말")]
    ]

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .white
        configuration.showsSeparators = true
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<SettingSection, Menu>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setController()
        setLayout()
        configureDataSource()
        updateSnapShot()
    }
    
    private func setController() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Menu>!
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<SettingSection, Menu>()
        snapshot.appendSections(SettingSection.allCases)
        snapshot.appendItems(menuList[0], toSection: .all)
        snapshot.appendItems(menuList[1], toSection: .personal)
        snapshot.appendItems(menuList[2], toSection: .etc)
        dataSource.apply(snapshot)
    }

}

