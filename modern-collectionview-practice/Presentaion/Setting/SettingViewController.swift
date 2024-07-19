//
//  ViewController.swift
//  modern-collectionview-practice
//
//  Created by junehee on 7/19/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.backgroundColor = .black
        configuration.showsSeparators = true
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setController()
        setLayout()
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

}

