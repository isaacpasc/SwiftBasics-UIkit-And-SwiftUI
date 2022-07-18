//
//  ResultsViewController.swift
//  News App UIKit
//
//  Created by Isaac Paschall on 6/8/22.
//

import UIKit

class ResultsViewController: UIViewController {

    private let articleCellIdentifier = "articlecell"
    private var newsViewModel: NewsViewModel

    private lazy var newsTableView: UITableView = { [weak self] in
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: articleCellIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavBarButton()
    }
    
    init(searchText: String,
         newsViewModel: NewsViewModel = NewsViewModel()) {
        self.newsViewModel = newsViewModel
        super.init(nibName: nil, bundle: nil)
        newsViewModel.searchText = searchText
        newsViewModel.newsDelegate = self
        title = "Most Relevant"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(changeFilter))
    }

    private func configureTableView() {
        view.addSubview(newsTableView)
        newsTableView.pinAllEdges(to: view)
    }

    @objc private func changeFilter() {
        newsViewModel.changeFilter()
    }
}

// MARK: - TableView Delegate/DataSource

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = newsTableView.dequeueReusableCell(withIdentifier: articleCellIdentifier,
                                                     for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let article = newsViewModel.articles[indexPath.row]

        guard let articleCell = cell as? ArticleCell else {
            return cell
        }

        articleCell.configure(article: article)
        articleCell.articleImage.loadImage(from: URL(string: article.urlToImage ?? ""),
                                           fallbackImage: UIImage(named: "fallback.jpg")!)
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ArticleDetailViewController(article: newsViewModel.articles[indexPath.row]),
                                                 animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == newsViewModel.articles.count - 1 {
            newsViewModel.fetchData(pagination: true)
        }
    }
}

// MARK: - NewsDelegate

extension ResultsViewController: NewsDelegate {

    func changedFilterText(text: String) {
        DispatchQueue.main.async {
            self.title = text
        }
    }

    func updateData() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }

    func scrollToTop() {
        DispatchQueue.main.async {
            self.newsTableView.setContentOffset(.zero, animated: true)
        }
    }
}
