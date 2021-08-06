//
//  CharactersViewModel.swift
//  BreakingBadDemo
//
//  Created by Juan Kruger
//

import Foundation

public class CharactersViewModel {
    
    var charactersViewModels = Observable([CharacterViewModel]())
    var errorMessage = Observable("")
    
    init() {
        
        loadCharacters()
    }
    
    public func loadCharacters() {
        
        WebService.requestCharacters() { [weak self] (fetchedCharacters, error) in
            
            if let error = error {
                
                self?.errorMessage.value = error.localizedDescription
            }
            if var fetchedCharacters = fetchedCharacters {
            
                fetchedCharacters.sort(by: { $0.name < $1.name })
                
                var viewModels = [CharacterViewModel]()
                for fetchedCharacter in fetchedCharacters {
                    
                    let characterViewModel = CharacterViewModel(character: fetchedCharacter)
                    viewModels.append(characterViewModel)
                }
                
                self?.charactersViewModels.value = viewModels
            }
        }
    }
}
