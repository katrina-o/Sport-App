//
//  ViewController.swift
//  Sport App
//
//  Created by Екатерина Орлова on 17.03.2025.
//

import UIKit

protocol SportViewProtocol: AnyObject {
    func reloadData()
}

final class SportViewController: UIViewController {
    // MARK: - Properties
    private let presenter: SportPresenterProtocol
    let sportManager = SportManager()
    var sportModel: [SportMainModel]?
    var filteredSports: [SportMainModel]?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(SportCell.self, forCellWithReuseIdentifier: SportCell.identifier)
        return collection
    }()
    
    private let typeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All", "Cardio", "Olympic Weightlifting", "Plyometrics", "Powerlifting", "Strength", "Stretching", "Strongman"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let muscleSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All", "Quadriceps", "Hamstrings", "Chest", "Back", "Shoulders", "Arms"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let difficultySegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All", "Beginner", "Intermediate", "Advanced"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        sportManager.fetchData { [weak self] response in
            self?.sportModel = response
            self?.filteredSports = response
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    init(presenter: SportPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "unavailable")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func filterSports() {
        let selectedType = typeSegmentedControl.selectedSegmentIndex == 0 ? nil : typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        let selectedMuscle = muscleSegmentedControl.selectedSegmentIndex == 0 ? nil : muscleSegmentedControl.titleForSegment(at: muscleSegmentedControl.selectedSegmentIndex)
        let selectedDifficulty = difficultySegmentedControl.selectedSegmentIndex == 0 ? nil : difficultySegmentedControl.titleForSegment(at: difficultySegmentedControl.selectedSegmentIndex)
        
        filteredSports = presenter.filterSports(byType: selectedType, muscle: selectedMuscle, difficulty: selectedDifficulty)
        collectionView.reloadData()
    }
}

// MARK: - Constraints
private extension SportViewController {
    func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(searchBar)
        view.addSubview(typeSegmentedControl)
        view.addSubview(muscleSegmentedControl)
        view.addSubview(difficultySegmentedControl)
        view.addSubview(collectionView)
        
        typeSegmentedControl.addTarget(self, action: #selector(filterSports), for: .valueChanged)
        muscleSegmentedControl.addTarget(self, action: #selector(filterSports), for: .valueChanged)
        difficultySegmentedControl.addTarget(self, action: #selector(filterSports), for: .valueChanged)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            
            typeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            typeSegmentedControl.bottomAnchor.constraint(equalTo: muscleSegmentedControl.topAnchor, constant: -10),
            typeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeSegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            muscleSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            muscleSegmentedControl.bottomAnchor.constraint(equalTo: difficultySegmentedControl.topAnchor, constant: -10),
            muscleSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            muscleSegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            difficultySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            difficultySegmentedControl.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
            difficultySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            difficultySegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - SportViewProtocol
extension SportViewController: SportViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension SportViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredSports = sportModel
        } else {
            filteredSports = sportModel?.filter { sport in
                sport.name.lowercased().contains(searchText.lowercased()) ||
                sport.type.lowercased().contains(searchText.lowercased()) ||
                sport.muscle.lowercased().contains(searchText.lowercased()) ||
                sport.difficulty.lowercased().contains(searchText.lowercased())
            }
        }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension SportViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredSports?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCell.identifier, for: indexPath) as? SportCell,
              let sport = filteredSports?[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.configure(with: sport)
        cell.backgroundColor = .blue.withAlphaComponent(0.7)
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 2
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SportViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle selection
    }
}

