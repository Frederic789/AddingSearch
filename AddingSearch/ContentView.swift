//
//  ContentView.swift
//  AddingSearch
//
//  Created by Student Account on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var searchSuggestions: [String] = []
    
    
    let movies = ["The Shawshank Redemption", "The Godfather", "The Dark Knight", "12 Angry Men", "Schindler's List", "The Lord of the Rings: The Return of the King", "Pulp Fiction", "The Good, the Bad and the Ugly", "Fight Club", "Forrest Gump"]
    
    var filteredMovies: [String] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Which movie would you like to see?", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(filteredMovies, id: \.self) { movie in
                    Text(movie)
                }
                
                .onSubmit {
                    searchSuggestions = searchText.isEmpty ? [] : movies.filter { $0.localizedCaseInsensitiveContains(searchText) }
                    
                }
            }
            
            if !searchSuggestions.isEmpty {
                List(searchSuggestions, id: \.self) { suggestion in
                    Text(suggestion)
                        .onTapGesture {
                            searchText = suggestion
                            // Add additional code here if needed
                        }
                }
            } else {
                List(filteredMovies, id: \.self) { movie in
                    Text(movie)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Which movie would you like to see?")
        .navigationTitle("Movies to Watch")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
