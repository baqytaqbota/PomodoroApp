//
//  SettingsViewController.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 30.11.2022.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private let settingsLabel = UILabel()
    private let tableView = UITableView()
    
    private let viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        setupComponents()
        configureSubviews()
        configureConstraints()
    }
    
    func setupComponents() {
        settingsLabel.text = "Settings"
        settingsLabel.textColor = .white
        
        setTableViewDelegates()
        tableView.allowsSelection = true
        tableView.backgroundColor = .black
        tableView.separatorColor = .gray
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSubviews() {
        view.addSubview(settingsLabel)
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
        settingsLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            $0.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(settingsLabel.snp.bottom).offset(34)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingsTableViewCell else { return UITableViewCell()}
        cell.model = viewModel.settingsList[indexPath.row]
        return cell
    }
}
