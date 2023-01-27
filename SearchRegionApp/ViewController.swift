//
//  ViewController.swift
//  SearchRegionApp
//
//  Created by Peter Chen on 24/1/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.showsCancelButton = false
        return sc
    }()
    
    var viewModel: RegionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel = RegionViewModel()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Select region"
        navigationItem.searchController = searchController
        navigationController?.hidesBarsWhenKeyboardAppears = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .systemGreen
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RegionTableViewCell", bundle: nil), forCellReuseIdentifier: "RegionTableViewCell")
        
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {

        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        if text.isEmpty {
            viewModel?.resetRegion({ [weak self] in
                self?.reloadData()
            })
            return
        }
        viewModel?.searchRegion(text, { [weak self] in
            self?.reloadData()
        })
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell") as? RegionTableViewCell,
            let vm = viewModel else {
            return UITableViewCell()
        }
        let currentRegion = vm.currentRegions[indexPath.row]
        cell.name.text = currentRegion
        cell.setCellType(isSelected: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let displayCell = cell as? RegionTableViewCell, let currentRegion = displayCell.name.text, let vm = viewModel else { return }
        if let selectedRegion = vm.selectedRegion, currentRegion == selectedRegion {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            displayCell.setCellType(isSelected: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.currentRegions.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RegionTableViewCell {
            cell.setCellType(isSelected: true)
            viewModel?.setSelectedRegion(cell.name.text)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RegionTableViewCell {
            cell.setCellType(isSelected: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
