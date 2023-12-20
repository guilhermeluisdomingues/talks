//
//  ViewController.swift
//  CocoaTalksFocusEngine
//
//  Created by Guilherme Domingues on 14/12/23.
//

import UIKit

final class FocusableView: UIView {
    
    private var textLabel: UILabel = {
        $0.font = .preferredFont(forTextStyle: .caption1)
        $0.textColor = .white.withAlphaComponent(0.8)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel(frame: .zero))
    
    override var canBecomeFocused: Bool {
        true
    }
    
    let text: String
    
    init(text: String) {
        self.text = text
        
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        // 1
        context.nextFocusedView?.backgroundColor = .white.withAlphaComponent(0.8)
        context.previouslyFocusedView?.backgroundColor = .darkGray
        
        // 2
        if let nextFocusedView: FocusableView = context.nextFocusedView as? FocusableView {
            nextFocusedView.textLabel.textColor = .darkGray
        }
        if let previouslyFocusedView: FocusableView = context.previouslyFocusedView as? FocusableView {
            previouslyFocusedView.textLabel.textColor = .white.withAlphaComponent(0.8)
        }
        
        // 3
        if isFocused {
            transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        } else {
            transform = .identity
        }
    }
    
    private func configureViews() {
        backgroundColor = .gray
        layer.cornerRadius = 12
        textLabel.text = text
    }
    
    private func setupViewHierarchy() {
        addSubview(textLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthAnchor.constraint(equalToConstant: 100),
            heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}

final class FocusEngineExampleView: UIView {
    
    private lazy var titleLabel: UILabel = {
        $0.text = "Olá, CocoaTalks"
        $0.font = .preferredFont(forTextStyle: .title1)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel(frame: .zero))

    private lazy var mainViewStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 48
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView(frame: .zero))
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        [mainViewStackView.subviews[2]]
    }
    
    init() {
        super.init(frame: .zero)
        self.setupViewHierarchy()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(mainViewStackView)
        
        ["A", "B", "C", "D", "E"].forEach({ text in
            let focusableView: FocusableView = FocusableView(text: text)
            focusableView.translatesAutoresizingMaskIntoConstraints = false
            mainViewStackView.addArrangedSubview(focusableView)
        })
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            mainViewStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            mainViewStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainViewStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view = FocusEngineExampleView()
    }

}

