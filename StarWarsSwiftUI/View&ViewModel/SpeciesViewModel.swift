//
//  SpeciesViewModel.swift
//  StarWarsSwiftUI
//
//  Created by Рустам Т on 8/13/23.
//

import Foundation

@MainActor
class SpeciesViewModel: ObservableObject {
    struct Returned: Codable {
        var next: String?
        var results: [Species]
    }
    @Published var speciesArray: [Species] = []
    @Published var isLoading = false
    var urlString = "https://swapi.dev/api/species/"
    
    func getData() async {
        isLoading = true
        guard let url = URL(string: urlString) else { isLoading = false
            return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data)
                urlString = returned.next ?? ""
                speciesArray += returned.results
                isLoading = false
            } catch {
                isLoading = false
                print("couldn't decode from JSON")
            }
        } catch {
            isLoading = false
            print("couldn't get data form URL")
        }
    }
    
    func loadNextIfNeeded(species: Species) async {
        guard let lastSpecies = speciesArray.last else { return  }
        if lastSpecies.id == species.id, urlString != "" {
            await getData() 
        }
    }
}
