//
//  ThemeCollectionViewCell.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 01.12.2022.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    var model: Theme? {
        didSet {
            configureCell()
        }
    }
    
    let themeLabel = UILabel()
    var themeImage = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        applyStyles()
        configureSubviews()
        configureConstraints()
    }
    
    private func applyStyles() {
        contentView.backgroundColor = .systemPink
        contentView.layer.cornerRadius = 16
        let contentViewBgColor = hexStringToUIColor(hex: "#EAEAEA")
        contentView.backgroundColor = contentViewBgColor
    
        themeLabel.textColor = .black
    }
    
    func selectedCell() {
        contentView.backgroundColor = .black
        themeLabel.textColor = .white
    }
    
    func deselectedCell() {
        let contentViewBgColor = hexStringToUIColor(hex: "#EAEAEA")
        contentView.backgroundColor = contentViewBgColor
        themeLabel.textColor = .black
    }
    
    private func configureSubviews() {
        contentView.addSubview(themeLabel)
    }
    
    private func configureConstraints() {
        themeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configureCell() {
        guard let model = model else { return }
        themeLabel.text = model.themeName
        themeImage = model.themeImage
    }
    
}
