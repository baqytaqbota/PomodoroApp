//
//  FocusCategoryViewController.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 01.12.2022.
//

import UIKit

class FocusCategoryViewController: UIViewController {

    var viewModel = FocusCategoryViewModel()
    var setImage: ((String)->())?
    
    let titleLabel = UILabel()
    let closeButton = UIButton()
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
    }
    
    func setupVC() {
        bindViewModel()
        applyStyles()
        setupComponents()
        setCollectionViewDelegates()
        configureSubviews()
        configureConstraints()
    }
    
    func bindViewModel() {
        viewModel.fetchTheme {
            self.collectionView?.reloadData()
        }
    }
    
    func applyStyles() {
        view.backgroundColor = .white
    }
    
    func setCollectionViewDelegates() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    func setupComponents() {
        titleLabel.text = "Focus Category"
        
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 180, height: 60)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(ThemeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
    }
    
    func configureSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.right.equalToSuperview().inset(16)
        }
        
        collectionView?.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(58)
        }
        
    }
    
    @objc
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    

}

extension FocusCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.themeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ThemeCollectionViewCell) else { return UICollectionViewCell() }
        cell.model = viewModel.themeList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setImage?(viewModel.themeList[indexPath.item].themeImage)
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeCollectionViewCell {
            cell.selectedCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeCollectionViewCell {
            cell.deselectedCell()
        }
    }
    
  
    
    
    
}
