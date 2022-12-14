//
//  ViewController.swift
//  UXperience
//
//  Created by Luiz Sena on 22/11/22.
//

import UIKit

class MainScreenViewController: UIViewController {

    private lazy var searchBar = UISearchController(searchResultsController: nil)

    private(set) var filterView = FilterController()
    private(set) var cardCollectionView = CardCollectionViewController()
    private var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesSearchBarWhenScrolling = false

        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Procurar Lei"
        navigationItem.searchController = searchBar
        cardCollectionView.viewModel = detailViewModel
        cardCollectionView.delegate = self

        // MARK: - TODO: trocar por protocolo ViewCode
        addSubviews()
        setupConstraints()
    }
}

extension MainScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        detailViewModel.filterJson(with: searchController.searchBar.text ?? "")
        cardCollectionView.cardView.reloadData()
    }
}

protocol CardCollectionViewDelegate: AnyObject {
    func teste(with viewModel: LawsModel)
}

extension MainScreenViewController: CardCollectionViewDelegate {
    func teste(with viewModel: LawsModel) {
        let rootView = DetailViewController()
        rootView.detailViewModel = viewModel
        navigationController?.pushViewController(rootView, animated: true)
    }
}
