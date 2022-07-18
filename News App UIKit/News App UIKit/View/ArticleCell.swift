//
//  ArticleCell.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import UIKit

class ArticleCell: UITableViewCell {

    private var safeArea: UILayoutGuide!

    lazy var articleImage: URLImageView = {
        let imageView = URLImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private lazy var articleDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()

    private lazy var articleAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()

    private lazy var articleDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .ultraLight)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        safeArea = layoutMarginsGuide
        configureImage()
        configureTitleLabel()
        configureDateLabel()
        configureAuthorLabel()
        configureDescription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(article: Article) {
        articleTitle.text = article.title
        articleAuthor.text = article.author
        articleDate.text = article.publishedAt?.utcToLocal()
        articleDescription.text = article.description
    }
    
    private func configureImage() {
        addSubview(articleImage)
        let constraints: [NSLayoutConstraint] = [
            articleImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: LayoutGuide.padding),
            articleImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -LayoutGuide.padding),
            articleImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutGuide.padding),
            articleImage.heightAnchor.constraint(equalToConstant: (LayoutGuide.articleCellImageHeight))
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTitleLabel() {
        addSubview(articleTitle)
        let constraints: [NSLayoutConstraint] = [
            articleTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: LayoutGuide.padding),
            articleTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -LayoutGuide.padding),
            articleTitle.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: LayoutGuide.padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureDateLabel() {
        addSubview(articleDate)
        let constraints: [NSLayoutConstraint] = [
            articleDate.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -LayoutGuide.padding),
            articleDate.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: LayoutGuide.padding),
            articleDate.widthAnchor.constraint(equalToConstant: 95)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureAuthorLabel() {
        addSubview(articleAuthor)
        let constraints: [NSLayoutConstraint] = [
            articleAuthor.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: LayoutGuide.padding),
            articleAuthor.trailingAnchor.constraint(equalTo: articleDate.leadingAnchor, constant: -LayoutGuide.padding),
            articleAuthor.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: LayoutGuide.padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureDescription() {
        addSubview(articleDescription)
        let constraints: [NSLayoutConstraint] = [
            articleDescription.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: LayoutGuide.padding),
            articleDescription.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -LayoutGuide.padding),
            articleDescription.topAnchor.constraint(equalTo: articleDate.bottomAnchor, constant: LayoutGuide.padding),
            articleDescription.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
