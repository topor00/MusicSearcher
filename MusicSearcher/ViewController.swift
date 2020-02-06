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
    var searchResponse: SearchResult? = nil
    private var timer: Timer?
    let networkDataFetcher = NetworkDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMainTableView()
        setupSearchBar()
        
        
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
        return searchResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = searchResponse?.results[indexPath.row]
        cell.textLabel?.text = track?.trackName
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=15"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchTracks(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else {return}
                self.searchResponse = searchResponse
                self.mainTable.reloadData()
            }
        })
        
    }
}
