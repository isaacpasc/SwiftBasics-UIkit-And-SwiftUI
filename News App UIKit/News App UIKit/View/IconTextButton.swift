//
//  IconTextButton.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import UIKit

final class IconTextButton: UIButton {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        addSubview(iconView)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    func configure(iconSystemName: String, labelText: String) {
        label.text = labelText
        iconView.image = UIImage(systemName: iconSystemName)
    }

    func disable() {
        isEnabled = false
        backgroundColor = .lightGray
    }

    func enable() {
        isEnabled = true
        backgroundColor = Theme.accentColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        let iconSize: CGFloat = 30
        let paddingBetweenIconAndLabel: CGFloat = 8
        let iconX: CGFloat = (frame.size.width - label.frame.size.width - iconSize - paddingBetweenIconAndLabel) / 2
        let iconY: CGFloat = (frame.size.height - iconSize) / 2
        let iconViewFrame = CGRect(x: iconX, y: iconY, width: iconSize, height: iconSize)
        iconView.frame = iconViewFrame
        label.frame = CGRect(x: (iconX + iconSize + paddingBetweenIconAndLabel),
                             y: 0,
                             width: label.frame.size.width,
                             height: frame.size.height)
    }
}
