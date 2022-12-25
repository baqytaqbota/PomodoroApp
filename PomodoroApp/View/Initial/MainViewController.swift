//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Акбота Бакыт on 29.11.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    private let bgImageView = UIImageView()
    private let focusCategoryButton = UIButton()
    private let timerLabel = UILabel()
    private let timerTextLabel = UILabel()
    private let playButton = UIButton()
    private let stopButton = UIButton()
    
    private var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTimeWillAppear()
    }
    
    private func getTimeWillAppear() {
        viewModel.getTimeLabelFromSettings()
        updatedTimer()
    }
    
    private func setupVC() {
        setupComponents()
        configureSubviews()
        configureConstraints()
    }
    
    private func setupComponents() {
        bgImageView.image = UIImage(named: "work")
        
        focusCategoryButton.setTitle("Focus Category", for: .normal)
        focusCategoryButton.setImage(UIImage(named: "Vector"), for: .normal)
        focusCategoryButton.imageEdgeInsets.right = 10
        focusCategoryButton.layer.cornerRadius = 20
        focusCategoryButton.clipsToBounds = true
        focusCategoryButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
        focusCategoryButton.addTarget(self, action: #selector(focusCategoryButtonTappped), for: .touchUpInside)

        timerLabel.text = UserDefaultsService.getFocusTime()
        timerLabel.font = UIFont.systemFont(ofSize: 44, weight: .regular)
        timerLabel.textColor = .white
        
        timerTextLabel.text = "Focus on your task"
        timerTextLabel.font = timerLabel.font.withSize(16)
        timerTextLabel.textColor = .white
        
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.layer.cornerRadius = 30
        playButton.clipsToBounds = true
        playButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        stopButton.setImage(UIImage(named: "stop"), for: .normal)
        stopButton.layer.cornerRadius = 30
        stopButton.clipsToBounds = true
        stopButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func focusCategoryButtonTappped() {
        let focusCategoryVC = FocusCategoryViewController()
        if let sheet = focusCategoryVC.sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return 362
                }
            ]
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        self.present(focusCategoryVC, animated: true)
        
        focusCategoryVC.setImage = { image in
            self.bgImageView.image = UIImage(named: image)
        }
    }
    
    @objc
    private func playButtonTapped() {
        viewModel.startTimer()
        updatedTimer()
        updatePlayBtnImage()
    }
    
    private func updatedTimer() {
        viewModel.updateViewIfNeeded = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .focus:
                self.timerLabel.text = UserDefaultsService.getFocusTime()
                self.timerTextLabel.text = "Focus on your task"
                self.playButton.setImage(UIImage(named: "play"), for: .normal)
            case .rest:
                self.timerLabel.text = UserDefaultsService.getBreakTime()
                self.timerTextLabel.text = "Break"
                self.playButton.setImage(UIImage(named: "play"), for: .normal)
            case .focusCount:
                self.timerLabel.text = self.formatTimer(self.viewModel.focusTime)
            case .restCount:
                self.timerLabel.text = self.formatTimer(self.viewModel.breakTime)
            }
        }
    }
    
    private func updatePlayBtnImage() {
        playButton.setImage(UIImage(named: viewModel.isChangeButtonImageIfNeeded ? "pause" : "play"), for: .normal)
    }
    
    @objc
    private func stopButtonTapped() {
        viewModel.stopTimer()
        updatePlayBtnImage()
        
        viewModel.updateViewIfNeeded = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .rest:
                DispatchQueue.main.async {
                    self.timerLabel.text = UserDefaultsService.getBreakTime()
                    self.timerTextLabel.text = "Break"
                }
            case .focus:
                DispatchQueue.main.async {
                    self.timerLabel.text = UserDefaultsService.getFocusTime()
                    self.timerTextLabel.text = "Focus on your task"
                }
            default:
                break
            }
        }
    }
    
    private func configureSubviews() {
        view.addSubview(bgImageView)
        view.addSubview(focusCategoryButton)
        view.addSubview(timerLabel)
        view.addSubview(timerTextLabel)
        view.addSubview(playButton)
        view.addSubview(stopButton)
    }
    
    private func configureConstraints() {
        bgImageView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        focusCategoryButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(108)
            $0.width.equalTo(180)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(focusCategoryButton.snp.bottom).offset(120)
            $0.centerX.equalToSuperview()
        }
        timerTextLabel.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        playButton.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp.bottom).offset(156)
            $0.width.height.equalTo(60)
            $0.left.equalToSuperview().inset(117)
        }
        stopButton.snp.makeConstraints {
            $0.centerY.equalTo(playButton.snp.centerY)
            $0.width.height.equalTo(60)
            $0.right.equalToSuperview().inset(117)
        }
    }
}
