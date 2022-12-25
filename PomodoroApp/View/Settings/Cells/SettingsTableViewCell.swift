//
//  SettingsTableViewCell.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 04.12.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let timeTextField = UITextField()
    
    var model: Settings? {
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
    
    func setupCell() {
        applyStyles()
        setupComponents()
        configureSubviews()
        configureConstraints()
    }
    
    func applyStyles() {
        selectionStyle = .none
        contentView.backgroundColor = .black
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    func configureCell() {
        titleLabel.text = model?.periodName
        timeTextField.text = model?.time
    }
    
    func setupComponents() {
        titleLabel.textColor = .white
        
        timeTextField.delegate = self
        timeTextField.textColor = .white
        timeTextField.keyboardType = .numberPad
        timeTextField.keyboardAppearance = .dark
    }
    
    func configureSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeTextField)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(11)
            $0.left.equalToSuperview().inset(16)
        }
        timeTextField.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
    }
}

extension SettingsTableViewCell: UITextFieldDelegate {
    func formatTimer(number: String) -> String {
        let cleanTimer = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "##:##"
        var result = ""
        var startIndex = cleanTimer.startIndex
        let endIndex = cleanTimer.endIndex
        
        for hash in mask where startIndex < endIndex {
            if hash == "#" {
                result.append(cleanTimer[startIndex])
                startIndex = cleanTimer.index(after: startIndex)
            } else {
                result.append(hash)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatTimer(number: newString)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let table: UITableView = self.superview as! UITableView
        let index = table.indexPath(for: self)
        let row = index?.row
        if row == 0 {
            if var text = textField.text, text.isEmpty {
                text = "25:00"
                textField.text = text
                UserDefaultsService.setFocusTime(value: text)
            } else {
                UserDefaultsService.setFocusTime(value: textField.text ?? "")
            }
        } else {
            if var text = textField.text, text.isEmpty {
                text = "05:00"
                textField.text = text
                UserDefaultsService.setBreakTime(value: text)
            } else {
                UserDefaultsService.setBreakTime(value: textField.text ?? "")
            }
        }
    }
}
