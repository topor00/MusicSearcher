//
//  ViewController.swift
//  MusicSearcher
//
//  Created by Станислав Жук on 05.02.2020.
//  Copyright © 2020 InsiderGroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMainTableView()
        setupSearchBar()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson"
        loadData(urlString: urlString) { (result) in
            switch result{
            case .success(let searchResult):
                searchResult.results.map { (track)  in
                    print("track.trackName: ", track.trackName)
                }
            case .failure(let error):
                print("error: ", error)
            }
        }
    }
    
    private func setupSearchBar(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupMainTableView() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "123"
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
