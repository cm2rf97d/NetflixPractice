//
//  TitlePreviewView.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/16.
//

import UIKit
import WebKit

class TitlePreviewView: UIView {
    // MARK: - Properties
    // MARK: - IBOutLets
    // MARK: - Scroll view
    private let mainScrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.showsVerticalScrollIndicator = true
        view.indicatorStyle = .black
        view.isScrollEnabled = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let scrollContentView: UIView = {
        let view: UIView = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .red
        button.isHidden = true
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView: WKWebView = WKWebView()
    let test: UIActivityIndicatorView  = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        return view
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Function
    func configre(with model: TitlePreviewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        downloadButton.isHidden = false
        
        guard let url: URL = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - setViews
    private func setViews() {
        addSubview(mainScrollView)
        mainScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(webView)
        scrollContentView.addSubview(titleLabel)
        scrollContentView.addSubview(overviewLabel)
        scrollContentView.addSubview(downloadButton)
    }
    
    // MARK: - setLayouts
    private func setLayouts() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(mainScrollView)
            make.leading.trailing.equalTo(self)
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(10)
            make.leading.trailing.equalTo(scrollContentView)
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(20)
            make.leading.equalTo(scrollContentView).offset(20)
            make.trailing.equalTo(scrollContentView)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(scrollContentView)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerX.equalTo(scrollContentView)
            make.top.equalTo(overviewLabel.snp.bottom).offset(25)
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
}
