//
//  ArticleDetailViewController.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/9/22.
//

import UIKit
import SafariServices

class ArticleDetailViewController: UIViewController {

    private let article: Article?
    private lazy var articleImage: URLImageView = {
        let imageView = URLImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let articleDate: UILabel = {
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

    private lazy var articleSource: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .ultraLight)
        return label
    }()

    private lazy var articleContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .ultraLight)
        return label
    }()

    private lazy var webViewButton: IconTextButton = { [weak self] in
        let button = IconTextButton()
        button.addTarget(self, action: #selector(openInSafari), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.enable()
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = LayoutGuide.padding
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()

    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
        configureScrollView()
        configureStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configureScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(scrollView)
    }

    private func configureStackView() {

        scrollView.addSubview(stackView)
        stackView.pinAllEdges(to: scrollView)
        stackView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true

        configureImage()
        configureTitleLabel()
        configureDateLabel()
        configureAuthorLabel()
        configureSource()
        configureContent()
        configureWebViewButton()
        configureNavBarButton()
        resizeScrollViewToFitContent()
    }

    private func resizeScrollViewToFitContent() {
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }

    private func configureImage() {
        stackView.addSubview(articleImage)
        configureImageConstraints()
        articleImage.loadImage(from: URL(string: article?.urlToImage ?? ""), fallbackImage: UIImage(named: "fallback.jpg")!)
    }

    private func configureImageConstraints() {
        let constraints: [NSLayoutConstraint] = [
            articleImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: LayoutGuide.padding),
            articleImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -LayoutGuide.padding),
            articleImage.topAnchor.constraint(equalTo: stackView.topAnchor, constant: LayoutGuide.padding),
            articleImage.heightAnchor.constraint(equalToConstant: (LayoutGuide.articleCellImageHeight * 2))
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureTitleLabel() {
        stackView.addSubview(articleTitle)
        articleTitle.text = article?.title
        configureTitleLabelConstraints()
    }

    private func configureTitleLabelConstraints() {
        let constraints: [NSLayoutConstraint] = [
            articleTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: LayoutGuide.padding),
            articleTitle.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -LayoutGuide.padding),
            articleTitle.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: LayoutGuide.padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureDateLabel() {
        stackView.addSubview(articleDate)
        configureDateLabelConstraints()
        articleDate.text = article?.publishedAt?.utcToLocal()
    }

    private func configureDateLabelConstraints() {
        let constraints: [NSLayoutConstraint] = [
            articleDate.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -LayoutGuide.padding),
            articleDate.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: LayoutGuide.padding),
            articleDate.widthAnchor.constraint(equalToConstant: 95)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureAuthorLabel() {
        stackView.addSubview(articleAuthor)
        configureAuthorLabelConstraints()
        articleAuthor.text = article?.author
    }

    private func configureAuthorLabelConstraints() {
        let constraints: [NSLayoutConstraint] = [
            articleAuthor.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: LayoutGuide.padding),
            articleAuthor.trailingAnchor.constraint(equalTo: articleDate.leadingAnchor, constant: -LayoutGuide.padding),
            articleAuthor.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: LayoutGuide.padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureSource() {
        stackView.addSubview(articleSource)
        configureSourceConstraints()
        if let source = article?.source?.name {
            articleSource.text = "Source: \(source)"
        }
    }

    private func configureSourceConstraints() {
        let constraints: [NSLayoutConstraint] = [
            articleSource.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: LayoutGuide.padding),
            articleSource.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -LayoutGuide.padding),
            articleSource.topAnchor.constraint(equalTo: articleDate.bottomAnchor, constant: LayoutGuide.padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureContent() {
        stackView.addSubview(articleContent)
        configureContentConstraints()
        if let content = article?.content {
            articleContent.text = String(repeating: content, count: 10)
        }
    }

    private func configureContentConstraints() {
        let constraints: [NSLayoutConstraint] = [
            articleContent.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: LayoutGuide.padding),
            articleContent.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -LayoutGuide.padding),
            articleContent.topAnchor.constraint(equalTo: articleSource.bottomAnchor, constant: LayoutGuide.padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureWebViewButton() {
        stackView.addSubview(webViewButton)
        configureWebViewButtonConstraints()
        webViewButton.configure(iconSystemName: "safari", labelText: "Open in Safari")
    }

    private func configureWebViewButtonConstraints() {
        let constraints: [NSLayoutConstraint] = [
            webViewButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: LayoutGuide.padding),
            stackView.trailingAnchor.constraint(equalTo: webViewButton.trailingAnchor, constant: LayoutGuide.padding),
            webViewButton.topAnchor.constraint(equalTo: articleContent.bottomAnchor, constant: LayoutGuide.padding),
            webViewButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            webViewButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureNavBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(presentShareSheet))
    }

    @objc private func presentShareSheet() {
        guard let url = URL(string: article?.url ?? "") else { return }
        let shareSheetViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareSheetViewController, animated: true, completion: nil)
    }

    @objc private func openInSafari() {
        guard let url = URL(string: article?.url ?? "") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
