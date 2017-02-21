//
//  MoviesTableViewController.swift
//  MoviesApp
//
//  Created by Douglas Queiroz on 15/02/17.
//  Copyright © 2017 Douglas Queiroz. All rights reserved.
//

import UIKit
import PKHUD

class MoviesTableViewController: UITableViewController {

    let movieRequester = MovieRequester()
    var searchController : UISearchController!
    var movies = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        [[UIBarButtonItem UIAppearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-60, -60)
//            forBarMetrics:UIBarMetricsDefault];
        
        
        
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
    
    func loadMovies(with title: String) {
        
        HUD.show(.progress)
        movieRequester.getMovies(with: title) { (movies, errorMsg) in
            HUD.hide()
            self.searchController.searchBar.endEditing(true)
            if let errorMsg = errorMsg {
                print(errorMsg)
            }else{
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SEGUE_MOVIE_DETAIL, sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        
        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_MOVIE_DETAIL {
            let indexPath = sender as! IndexPath
            let movie = movies[indexPath.row]
            
            let movieDetailVC = segue.destination as! MovieDetailViewController
            movieDetailVC.movie = movie
        }
    }
 

}

extension MoviesTableViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let title = searchBar.text
        loadMovies(with: title!)
        
        searchBar.endEditing(true)
    }
}
