//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Douglas Queiroz on 20/02/17.
//  Copyright © 2017 Douglas Queiroz. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class MovieDetailViewController: UIViewController {

    var movie: Movie?
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var txtMovieDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            imgMovie.sd_setImage(with: URL(string: movie.urlPoster!))
            self.txtMovieDescription.text = movie.title
        }
    }

    @IBAction func btnSaveAction(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(movie!)
        }
    }
}
