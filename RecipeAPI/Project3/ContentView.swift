//
//  ContentView.swift
//  Project3
//
//  Created by Kevin Deras on 4/12/21.
//
import CoreImage
import SwiftUI
import Foundation


struct Recipe: Identifiable{
    var id = UUID()
    var name: String
}
struct RecipeInfo: Decodable{
    let id: Int?
    let recipe: String?
    let title: String?
    let instructionsReadOnly: String?
}

struct RecipeRow: View{
    var recipe: Recipe
    var body: some View{
        Text("\(recipe.name)")
    }
}

let headers = [
    "x-rapidapi-key": "947a163868msh91f67411fa2a1ffp1a6faajsn964d069ac310",
    "x-rapidapi-host": "webknox-recipes.p.rapidapi.com"
]

struct ContentView: View {
    @State var RecipeTitle = ""
    @State var instructionsReadOnly = ""
    @State var recipeName = "Recipe"
   
    
    
    var recipe: Recipe
    var body: some View {
        NavigationView{
        VStack{
        TextField("\(recipeName)", text: .constant(""))
            .padding().position(x:180,y:30)
            Button(action: DisplayRecipes) {
                Text("Search")
            }.position(x:280, y:-40)
            
            Image("recipe.jpg")
                .resizable()
                    .frame(width: 200.0, height: 200.0)
            //Display?Text("\(RecipeImage)")
            Text("\(RecipeTitle)")
            Text("\(recipeName)")
            List{
                Text("\(instructionsReadOnly)")
            }
            .navigationBarTitle("New Cook Book")
            
        }
        
        
        }
        
}
    struct Post: Codable, Identifiable{
        let id = UUID()
        //let recipe: String
        var title: String
        var instructionsReadOnly: String
    }
    func DisplayRecipes(){
        //Write the function to call the web api.
       
        guard let url = URL(string: "http://webknox.com:8080/recipes/randomPopular?limitLicense=100") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode(Post.self, from: data!)
            RecipeTitle = posts.title
            
            instructionsReadOnly = posts.instructionsReadOnly
            
            print(posts.instructionsReadOnly.description)
           
        }
        .resume()
    }
}
func GetRecipeData(){
    let request = NSMutableURLRequest(url: NSURL(string: "http://webknox.com:8080/recipes/randomPopular?limitLicense=100")! as URL,
    cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
        }
        //decode here maybe??
    })

    dataTask.resume()
}

func GetRecipeInfo(){
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let first = Recipe(name: "Chicken Alfredo")
        ContentView( recipe: first)
    }
    struct ListView: View{
        var body: some View{
            let first = Recipe(name: "Chicken Alfredo")
            let second = Recipe(name: "Hamburger Helper")
            let third = Recipe(name: "Meat Loaf")
            let fourth = Recipe(name: "Meatball hoagie")
            let fifth = Recipe(name: "Cheese Cake")
            let sixth = Recipe(name: "Brownies")
            let seventh = Recipe(name: "Gravy")
            let eighth = Recipe(name: "Mac and Cheese")
            let nineth = Recipe(name: "Spaghetti")
            let tenth = Recipe(name: "Fried Chicken")
            let recipes =  [first, second, third, fourth, fifth, sixth, seventh, eighth, nineth, tenth]
            return List(recipes){recipe in RecipeRow(recipe: recipe)}
    }
}
}
