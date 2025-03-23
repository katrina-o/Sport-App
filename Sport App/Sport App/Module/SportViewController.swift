//
//  ViewController.swift
//  Sport App
//
//  Created by Екатерина Орлова on 17.03.2025.
//

import UIKit

class SportViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
     var collectionView: UICollectionView {
        let collection = UICollectionView()
        return collection
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

