//
//  ViewController.swift
//  TikTokComments
//
//  Created by Rakuyo on 2024/3/29.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var toolView: ToolView = {
        let _view = ToolView()
        _view.postTextChangeBlock = { [weak self] in
            guard let this = self else { return }
            
            this.postLabel.text = $0
            this.updateWidthLayout()
        }
        _view.replyTextChangeBlock = { [weak self] in
            guard let this = self else { return }
            
            this.replyLabel.text = $0
            this.atLabel.isHidden = $0.isEmpty
            this.replyStackView.isHidden = $0.isEmpty
            
            this.updateWidthLayout()
        }
        return _view
    }()
    
    private lazy var skeletonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .cyan
        stackView.spacing = 1
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var postStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .blue
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.text = toolView.postText
        label.textColor = .label
        return label
    }()
    
    private lazy var meLabel: UILabel = {
        let label = UILabel()
        label.text = "我"
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private lazy var atLabel: UILabel = {
        let label = UILabel()
        label.isHidden = toolView.replyText.isEmpty
        label.backgroundColor = .green
        label.text = "@"
        label.textColor = .label
        return label
    }()
    
    private lazy var replyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = toolView.replyText.isEmpty
        stackView.backgroundColor = .red
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var replyLabel: UILabel = {
        let label = UILabel()
        label.text = toolView.replyText
        label.backgroundColor = .orange
        label.textColor = .label
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "作者"
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private lazy var widthLayouts: [Bool: NSLayoutConstraint] = [
        true: replyLabel.widthAnchor.constraint(lessThanOrEqualTo: postLabel.widthAnchor),
        false: postLabel.widthAnchor.constraint(lessThanOrEqualTo: replyLabel.widthAnchor)
    ]
}

// MARK: - Life cycle

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TikTok Comments"
        
        view.backgroundColor = .systemGroupedBackground
        
        addSubviews()
        addLayout()
    }
}

// MARK: - Config

private extension ViewController {
    func addSubviews() {
        view.addSubview(toolView)
        view.addSubview(skeletonStackView)
        
        skeletonStackView.addArrangedSubview(postStackView)
        skeletonStackView.addArrangedSubview(atLabel)
        skeletonStackView.addArrangedSubview(replyStackView)
        
        postStackView.addArrangedSubview(postLabel)
        postStackView.addArrangedSubview(meLabel)
        
        replyStackView.addArrangedSubview(replyLabel)
        replyStackView.addArrangedSubview(authorLabel)
    }
    
    func addLayout() {
        toolView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            toolView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            toolView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
        ])
        toolView.setContentHuggingPriority(.required, for: .vertical)
        
        skeletonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonStackView.topAnchor.constraint(equalTo: toolView.bottomAnchor, constant: 50),
            skeletonStackView.leadingAnchor.constraint(equalTo: toolView.leadingAnchor),
            skeletonStackView.trailingAnchor.constraint(equalTo: toolView.trailingAnchor),
            skeletonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        updateWidthLayout()
        
        meLabel.setContentHuggingPriority(.required, for: .horizontal)
        meLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        atLabel.setContentHuggingPriority(.required, for: .horizontal)
        atLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        authorLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func updateWidthLayout() {
        let postLonger = toolView.postText.count > toolView.replyText.count
        widthLayouts[postLonger]?.isActive = true
        widthLayouts[!postLonger]?.isActive = false
        
        let firstLabel: UILabel
        let secondLabel: UILabel
        
        if postLonger {
            firstLabel = postLabel
            secondLabel = replyLabel
        } else {
            firstLabel = replyLabel
            secondLabel = postLabel
        }
        
        firstLabel.setContentHuggingPriority(.required, for: .horizontal)
        firstLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        secondLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        secondLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
