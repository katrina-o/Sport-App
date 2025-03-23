//
//  SportCell.swift
//  Sport App
//
//  Created by Екатерина Орлова on 18.03.2025.
//

import UIKit

struct SportMainModel: Codable {
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    var instructions: String
    var isOnLikeList: Bool = false
}

class SportCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = SportCell.description()
    private var isOnLikeList: Bool = false
    
    private lazy var nameLabel = UILabel.makeCustomLabel(font: UIFont.systemFont(ofSize: 35), textColor: .blue)
    private lazy var typeLabel = UILabel.makeCustomLabel(font: UIFont.systemFont(ofSize: 20), textColor: .blue)
    private lazy var muscleLabel = UILabel.makeCustomLabel(font: UIFont.systemFont(ofSize: 20), textColor: .blue)
    private lazy var equipmentLabel = UILabel.makeCustomLabel(font: UIFont.systemFont(ofSize: 20), textColor: .blue)
    private lazy var difficultyLabel = UILabel.makeCustomLabel(font: UIFont.systemFont(ofSize: 20), textColor: .blue)
    private lazy var instructionsLabel = UILabel.makeCustomLabel(font: UIFont.systemFont(ofSize: 20), textColor: .blue)
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(configureLikeButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func configureLikeButton() {
        let image = isOnLikeList ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(image, for: .normal)
    }
}

// MARK: - ConfigurableViewProtocol
extension SportCell: ConfigurableViewProtocol {
    func configure(with model: SportMainModel) {
        nameLabel.text = model.name
        typeLabel.text = "Type: \(model.type)"
        muscleLabel.text = "Muscle: \(model.muscle)"
        equipmentLabel.text = "Equipment: \(model.equipment)"
        difficultyLabel.text = "Difficulty: \(model.difficulty)"
        instructionsLabel.text = "Instructions: \(model.instructions)"
        self.isOnLikeList = model.isOnLikeList
        configureLikeButton()
    }
}
private extension SportCell {
    func setupViews() {
        [nameLabel, typeLabel, muscleLabel, equipmentLabel, difficultyLabel, instructionsLabel, likeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
           
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                      
            muscleLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            muscleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            muscleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            equipmentLabel.topAnchor.constraint(equalTo: muscleLabel.bottomAnchor, constant: 5),
            equipmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            equipmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            difficultyLabel.topAnchor.constraint(equalTo: equipmentLabel.bottomAnchor, constant: 5),
            difficultyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            difficultyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            instructionsLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 5),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            likeButton.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
