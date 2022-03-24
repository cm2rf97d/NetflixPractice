//
//  SearchResultsView.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/16.
//

import UIKit

class SearchResultsView: UIView {
    // MARK: - Properties
    
    // MARK: - IBOutLets
    let mainCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Function
    // MARK: - setViews
    private func setViews() {
        addSubview(mainCollectionView)
    }
    
    // MARK: - setLayouts
    private func setLayouts() {
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
