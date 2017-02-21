//
//  MyMoviesTableViewController.swift
//  MoviesApp
//
//  Created by Douglas Queiroz on 15/02/17.
//  Copyright © 2017 Douglas Queiroz. All rights reserved.
//

import UIKit
import RealmSwift

class MyMoviesTableViewController: UITableViewController {
    
    let movieRequester = MovieRequester()
    var myMovies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        myMovies = realm.objects(Movie.self).reversed()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMovies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMovieCell", for: indexPath)
        
        let movie = myMovies[indexPath.row]
        cell.textLabel?.text = movie.title
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SEGUE_MOVIE_DETAIL, sender: indexPath)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_MOVIE_DETAIL {
            let indexPath = sender as! IndexPath
            let movie = myMovies[indexPath.row]
            
            let movieDetailVC = segue.destination as! MovieDetailViewController
            movieDetailVC.movie = movie
        }
    }

}
