//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func presentLoadingView()
    func collectionViewTableViewCellDidTapCell(model: TitlePreviewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier: String = "CollectionViewTableViewCell"
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    // MARK: - IBOutLets
    private var titles: [Title] = []
    
    private let homeCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 144, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setLayouts()
        setCollectionViewDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setViews
    private func setViews() {
        self.contentView.addSubview(homeCollectionView)
    }
    
    // MARK: - setLayouts
    private func setLayouts() {
        homeCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: - Function
    private func setCollectionViewDelegate() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
    func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.homeCollectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        guard let model = titles[indexPath.row].poster_path else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.presentLoadingView()
        let title = titles[indexPath.row]
        guard let titleName: String = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getMovie(with: titleName + "trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let title = self?.titles[indexPath.row]
                guard let titleOverview: String = title?.overview else { return }
                let model: TitlePreviewModel = TitlePreviewModel(title: titleName,
                                                                 youtubeView: videoElement,
                                                                 titleOverview: titleOverview)
                self?.delegate?.collectionViewTableViewCellDidTapCell(model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config: UIContextMenuConfiguration = UIContextMenuConfiguration(identifier: nil,
                                                                            previewProvider: nil) { [weak self]_ in
            let downloadAction = UIAction(title: "download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
    }
}
