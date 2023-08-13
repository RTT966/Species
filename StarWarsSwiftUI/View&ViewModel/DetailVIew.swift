//
//  DetailVIew.swift
//  StarWarsSwiftUI
//
//  Created by Рустам Т on 8/13/23.
//

import SwiftUI

struct DetailVIew: View {
    let species: Species
    var body: some View {
        VStack(alignment: .leading) {
            Text(species.name)
                .font(.largeTitle)
                .bold()
            Rectangle()
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
            Group {
                HStack(alignment: .top){
                    Text("Classification:")
                        .bold()
                    Text(species.classification)
                }
                
                HStack(alignment: .top){
                    Text("Designation:")
                        .bold()
                    Text(species.designation)
                }
                
                HStack(alignment: .top){
                    Text("Height:")
                        .bold()
                    Text(species.average_height)
                    Spacer()
                    Text("Lifespan:")
                        .bold()
                    Text(species.average_lifespan)
                }
                
                HStack(alignment: .top){
                    Text("Language:")
                        .bold()
                    Text(species.language)
                }
                
                HStack(alignment: .top){
                    Text("Skin Color:")
                        .bold()
                    Text(species.skin_colors)
                }
                
                HStack(alignment: .top){
                    Text("Eye Color:")
                        .bold()
                    Text(species.eye_colors)
                }
            }
            .font(.title2)
            VStack {
                AsyncImage(url: URL(string: returnSpeciesUrl())) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .shadow(radius: 15)
                        .animation(.default, value: image)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func returnSpeciesUrl()-> String {
        var newName = species.name.replacingOccurrences(of: " ", with: "-")
        newName = newName.replacingOccurrences(of: "'", with: "")
        return "https://gallaugher.com/wp-content/uploads/2023/04/\(newName).jpg"
    }
}

struct DetailVIew_Previews: PreviewProvider {
    static var previews: some View {
        DetailVIew(species: Species(name: "Jack", classification: "Mongodll", designation: "Eath", average_height: "138", average_lifespan: "189", language: "Gotrhak", skin_colors: "Black", hair_colors: "Blue", eye_colors: "Yellow"))
    }
}
