//
//  ContentView.swift
//  StarWarsSwiftUI
//
//  Created by Рустам Т on 8/11/23.
//

import SwiftUI

struct SpeciesListView: View {
    @StateObject var speciesVM = SpeciesViewModel()
    var body: some View {
        VStack {
            NavigationStack{
                ZStack {
                    List(speciesVM.speciesArray) { species in
                        LazyVStack {
                            NavigationLink {
                                DetailVIew(species: species)
                            } label: {
                                Text(species.name)
                            }
                        }
                        .task {
                            await speciesVM.loadNextIfNeeded(species: species)
                        }
                    }
                    .font(.title)
                    .listStyle(.plain)
                    .navigationTitle("Species")
                    if speciesVM.isLoading {
                        ProgressView()
                            .scaleEffect(4)
                            .tint(.green)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(speciesVM.speciesArray.count) Species Returned")
                    }
                }
            }
            .padding()
            .task {
                await speciesVM.getData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
