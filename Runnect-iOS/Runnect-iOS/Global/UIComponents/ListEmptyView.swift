//
//  ListEmptyView.swift
//  Runnect-iOS
//
//  Created by sejin on 2023/01/06.
//

import UIKit

protocol ListEmptyViewDelegate: AnyObject {
    func emptyViewButtonTapped()
}

final class ListEmptyView: UIView {

    // MARK: - Properties
    
    weak var delegate: ListEmptyViewDelegate?
    
    var buttonTapAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private let mainImageView = UIImageView().then {
        $0.image = ImageLiterals.imgStorage
        $0.clipsToBounds = true
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .b4
        $0.textColor = .g2
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private let bottomButton = CustomButton(title: "코스 그리기")
    
    private lazy var containerStackView = UIStackView(
        arrangedSubviews: [mainImageView, descriptionLabel, bottomButton]
    ).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 24
    }

    // MARK: - initialization
    
    init(description: String, buttonTitle: String) {
        super.init(frame: .zero)
        self.setUI(description: description, buttonTitle: buttonTitle)
        self.setLayout()
        self.setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension ListEmptyView {
    private func setAddTarget() {
        bottomButton.addTarget(self, action: #selector(bottomButtonDidTap), for: .touchUpInside)
    }
    
    public func setImage(_ image: UIImage, size: CGSize) {
        self.mainImageView.image = image
        self.mainImageView.snp.updateConstraints { make in
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
    }
}

// MARK: - @objc Function

extension ListEmptyView {
    @objc private func bottomButtonDidTap() {
        delegate?.emptyViewButtonTapped()
        self.buttonTapAction?()
    }
}

// MARK: - UI & Layout

extension ListEmptyView {
    private func setUI(description: String, buttonTitle: String) {
        self.backgroundColor = .clear
        
        self.descriptionLabel.text = description
        self.bottomButton.setTitle(title: buttonTitle)
    }
    
    private func setLayout() {
        self.addSubviews(containerStackView)
        
        bottomButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints { make in
            make.width.height.equalTo(148)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
