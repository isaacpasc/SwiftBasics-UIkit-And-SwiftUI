//
//  SearchViewController.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import UIKit

class SearchViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "News"
        label.font = .systemFont(ofSize: 150, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.accentColor
        return label
    }()

    private lazy var searchTextField: UITextField = { [weak self] in
        let textField = UITextField()
        textField.delegate = self
        textField.clearButtonMode = .always
        textField.returnKeyType = .search
        textField.backgroundColor = .lightGray
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        textField.minimumFontSize = 30
        textField.tintColor = Theme.accentColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var searchButton: IconTextButton = { [weak self] in
        let button = IconTextButton()
        button.disable()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = Theme.accentColor
        view.backgroundColor = .white
        configureTitle()
        configureSearchTextField()
        configureSearchButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }

    private func configureTitle() {
        view.addSubview(titleLabel)
        configureTitleConstraints()
    }

    private func configureTitleConstraints() {
        let constraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: (LayoutGuide.padding * 2))
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureSearchTextField() {
        view.addSubview(searchTextField)
        configureSearchTextFieldConstraints()
    }

    private func configureSearchTextFieldConstraints() {
        let constraints: [NSLayoutConstraint] = [
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGuide.padding),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGuide.padding),
            searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: (LayoutGuide.padding * 2))
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.configure(iconSystemName: "magnifyingglass", labelText: "Search")
        configureSearchButtonConstraints()
    }

    private func configureSearchButtonConstraints() {
        let constraints: [NSLayoutConstraint] = [
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (LayoutGuide.padding * 2)),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(LayoutGuide.padding * 2)),
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: (LayoutGuide.padding * 2)),
            searchButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func search() {
        searchTextField.resignFirstResponder()
        if let text = searchTextField.text {
            if !text.isEmptyAfterRemovingWhitespaces() {
                navigationController?.pushViewController(ResultsViewController(searchText: text), animated: true)
            }
        }
    }
}

// MARK: - TextField Delegate

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search()
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmptyAfterRemovingWhitespaces() {
                searchButton.disable()
            } else {
                searchButton.enable()
            }
        } else {
            searchButton.disable()
        }
    }
}
