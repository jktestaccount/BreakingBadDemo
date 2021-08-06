//
//  CharactersTableViewController.swift
//  BreakingBadDemo
//
//  Created by Juan Kruger
//

import UIKit

class CharactersTableViewController: UITableViewController {

    let viewModel = CharactersViewModel()
    
    let loadingIndicator = UIActivityIndicatorView(style: .medium)
    let searchController = UISearchController(searchResultsController: nil)
    let cellIdentifier = "CharacterCell"
    let placeholderImage = UIImage(named: "CharactersImagePlaceholder")
    
    private var characterViewModels: [CharacterViewModel]?
    private var errorMessage: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        createBindings()
    }

    // MARK: - Custom
    private func createBindings() {
        
        viewModel.charactersViewModels.bind { [weak self] characterViewModels in
            self?.characterViewModels = characterViewModels
            self?.tableView.reloadData()
        }
        
        viewModel.errorMessage.bind { [weak self] errorMessage in
            
            if errorMessage.count > 0 {
                
                let alertController = UIAlertController(title: "Error".localized, message: errorMessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return characterViewModels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharacterTableViewCell
        
        if let characterViewModel = characterViewModels?[indexPath.row] {
            
            cell.update(characterViewModel)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let characterViewModel = characterViewModels?[indexPath.row] {
            
            let characterViewController = CharacterViewController(characterViewModel: characterViewModel)
            self.navigationController?.pushViewController(characterViewController, animated: true)
        }
    }
}
