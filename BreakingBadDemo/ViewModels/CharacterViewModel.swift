//
//  CharacterViewModel.swift
//  BreakingBadDemo
//
//  Created by Juan Kruger
//

import Foundation

public class CharacterViewModel {
    
    var name = Observable("")
    var occupation = Observable("")
    var status = Observable("")
    var nickName = Observable("")
    var seasons = Observable("")
    var imageURLString = Observable("")
    
    init(character: Character) {
        
        name.value = character.name
        occupation.value = character.occupation.joined(separator: ", ")
        status.value = character.status
        imageURLString.value = character.imgURLString
        nickName.value = character.nickname
        
        var seasonsDesc = character.appearance.description
        seasonsDesc = seasonsDesc.replacingOccurrences(of: "[", with: "")
        seasonsDesc = seasonsDesc.replacingOccurrences(of: "]", with: "")
        seasons.value = seasonsDesc
    }
    
    
}
