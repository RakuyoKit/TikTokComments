//
//  ToolView.swift
//  TikTokComments
//
//  Created by Rakuyo on 2024/3/29.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

final class ToolView: UIView {
    private lazy var skeletonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var postView: InputView = {
        let view = InputView()
        view.label.text = "发帖人："
        view.textField.text = "你好呀大黄鸭！嘿嘿大黄鸭，嘿嘿大黄鸭"
        return view
    }()
    
    private lazy var replyView: InputView = {
        let view = InputView()
        view.label.text = "回复者："
        return view
    }()
    
    var postText: String { postView.textField.text ?? "" }
    lazy var postTextChangeBlock: ((String) -> Void)? = nil {
        didSet { postView.textChangeBlock = postTextChangeBlock }
    }
    
    var replyText: String { replyView.textField.text ?? "" }
    lazy var replyTextChangeBlock: ((String) -> Void)? = nil {
        didSet { replyView.textChangeBlock = replyTextChangeBlock }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        addSubview(skeletonStackView)
        skeletonStackView.addArrangedSubview(postView)
        skeletonStackView.addArrangedSubview(replyView)
        
        skeletonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonStackView.topAnchor.constraint(equalTo: topAnchor),
            skeletonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            skeletonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            skeletonStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
