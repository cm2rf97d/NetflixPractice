//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/16.
//

import UIKit

class TitlePreviewViewController: UIViewController {
    // MARK: - Properties
    private let titlePreviewView: TitlePreviewView = TitlePreviewView()
    var model: TitlePreviewModel? {
        didSet {
            guard let model = model else { return }
            titlePreviewView.configre(with: model)
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func loadView() {
        super.loadView()
        self.view = titlePreviewView
    }
    
    // MARK: - Set navigation
    private func setNavigation() {
        navigationController?.navigationBar.tintColor = .white
    }
}
