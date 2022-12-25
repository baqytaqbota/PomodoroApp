//
//  HistoryViewController.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 30.11.2022.
//

import UIKit
import SnapKit

final class HistoryViewController: UIViewController {
    
    private let historyLabel = UILabel()
    private let tableView = UITableView()
    
    private let viewModel = HistoryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        setupComponents()
        configureSubviews()
        configureConstraints()
    }
    
    private func setupComponents() {
        historyLabel.text = "History"
        historyLabel.textColor = .white
        
        setTableViewDelegates()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(HistoryHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.sectionHeaderTopPadding = 0
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureSubviews() {
        view.addSubview(historyLabel)
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        historyLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            $0.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(historyLabel.snp.bottom).offset(26)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.historyList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HistoryHeader else { return UIView() }
        header.dateLabel.text = viewModel.historyList[section].date
        return header
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.historyList[section].period.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HistoryTableViewCell else { return UITableViewCell() }
        cell.model = viewModel.historyList[indexPath.section].period[indexPath.row]
        return cell
    }
}
