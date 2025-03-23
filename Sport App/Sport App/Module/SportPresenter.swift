//
//  SportPresenter.swift
//  Sport App
//
//  Created by Екатерина Орлова on 18.03.2025.
//

import Foundation

protocol SportPresenterProtocol {
    func toggleProductLike(at index: Int)
    func getSportViewModel(at index: Int) -> SportMainModel?
    func filterSports(byType type: String?, muscle: String?, difficulty: String?) -> [SportMainModel]
}

final class SportPresenter {
    
    private weak var view: SportViewProtocol?
    private var sports: [SportMainModel] = []
    
    init() {}
    
    func setupView(_ view: SportViewProtocol) {
        self.view = view
    }
}

extension SportPresenter: SportPresenterProtocol {
//    func getSportViewModel(at index: Int) -> SportMainModel? {
//        guard let sport = sports[safe: index] else { return nil }
//        var updatedSport = sport
//        
//        let viewModel = SportMainModel(
//            name: updatedSport.name,
//            type : updatedSport.type,
//            muscle : updatedSport.muscle,
//            equipment : updatedSport.equipment,
//            difficulty : updatedSport.difficulty,
//            instructions : updatedSport.instructions,
//            isOnLikeList : updatedSport.isOnLikeList
//        )
//        return viewModel
//    }
    func getSportViewModel(at index: Int) -> SportMainModel? {
        guard let sport = sports[safe: index] else { return nil }
        return sport
    }
    
    func toggleProductLike(at index: Int) {
        guard sports[safe: index] != nil else { return }
        sports[index].isOnLikeList.toggle()
        view?.reloadData()
    }
    
    func filterSports(byType type: String?, muscle: String?, difficulty: String?) -> [SportMainModel] {
        return sports.filter { sport in
            (type == nil || sport.type == type) &&
            (muscle == nil || sport.muscle == muscle) &&
            (difficulty == nil || sport.difficulty == difficulty)
        }
    }
}
