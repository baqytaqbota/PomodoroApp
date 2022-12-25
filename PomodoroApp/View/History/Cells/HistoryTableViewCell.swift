//
//  HistoryTableViewCell.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 12.12.2022.
//

import UIKit
import SnapKit

class HistoryTableViewCell: UITableViewCell {
    
    private let timeTitleLabel = UILabel()
    private let timeLabel = UILabel()
    private let separatorView = UIView()
    
    var model: Period? {
        didSet {
            configureCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        timeTitleLabel.text = model?.periodName
        timeLabel.text = model?.periodDuration
    }
    
    private func setupCell() {
        applyStyles()
        setupComponents()
        configureSubviews()
        configureConstraints()
    }
    
    private func applyStyles() {
        selectionStyle = .none
        contentView.backgroundColor = .black
        separatorView.backgroundColor = .gray
    }
    
    private func setupComponents() {
        timeTitleLabel.textColor = .white
        timeLabel.textColor = .white
    }
    
    private func configureSubviews() {
        contentView.addSubview(timeTitleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(separatorView)
    }
    
    private func configureConstraints() {
        timeTitleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(11)
            $0.left.equalToSuperview().inset(16)
        }
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeTitleLabel.snp.centerY)
            $0.left.equalTo(timeTitleLabel.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
        separatorView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
