//
//  Project3App.swift
//  Project3
//
//  Created by Kevin Deras on 4/12/21.
//

import SwiftUI

@main
struct Project3App: App {
    var body: some Scene {
        WindowGroup {
            let first = Recipe(name: "Chicken Alfredo")
            ContentView(recipe: first)
        }
    }
}
