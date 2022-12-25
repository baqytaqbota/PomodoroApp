//
//  HistoryHeader.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 12.12.2022.
//

import UIKit
import SnapKit

final class HistoryHeader: UITableViewHeaderFooterView {
    
    let dateLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        setupComponents()
        configureSubviews()
        configureConstraints()
    }

    private func setupComponents() {
        contentView.backgroundColor = .black
        
        dateLabel.textColor = .white
    }
    
    private func configureSubviews() {
        contentView.addSubview(dateLabel)
    }
    
    private func configureConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26).priority(999)
            $0.left.right.equalToSuperview().inset(16).priority(999)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
