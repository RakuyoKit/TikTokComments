//
//  InputView.swift
//  TikTokComments
//
//  Created by Rakuyo on 2024/3/29.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

final class InputView: UIView {
    private lazy var skeletonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.textColor = .label
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var textChangeBlock: ((String) -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    func config() {
        addSubview(skeletonStackView)
        skeletonStackView.addArrangedSubview(label)
        skeletonStackView.addArrangedSubview(textField)
        
        skeletonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonStackView.topAnchor.constraint(equalTo: topAnchor),
            skeletonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            skeletonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            skeletonStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        textChangeBlock?(textField.text ?? "")
    }
}
