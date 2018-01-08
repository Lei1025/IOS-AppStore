//
//  Models.swift
//  AppStore
//
//  Created by Lei Liu on 2018/1/6.
//  Copyright © 2018年 Lei Liu. All rights reserved.
//

import Foundation
import UIKit

class Featured : Decodable{
    var bannerCategory : AppCategory
    var categories : [AppCategory]?
}

class AppCategory: Decodable{
    var name : String?
    var apps : [App]?
    var type : String?
    
    static func fetchFeaturedApps(completionHandler: @escaping ([AppCategory]) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error ?? "url error")
            }
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(Featured.self, from: data)
                
                var appCategories = [AppCategory]()
                appCategories = json.categories!
                print(appCategories)
                
                DispatchQueue.main.async {
                    completionHandler(appCategories)
                }
        
            }catch let err{
                print(err)
            }
        }.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory]{
        let bestNewAppCategory = AppCategory()
        bestNewAppCategory.name = "Best New Apps"
        var apps = [App]()
        
        let frozenApp = App()
        frozenApp.Name = "Disney Build It: Frozen"
        frozenApp.ImageName = "frozen"
        frozenApp.Category = "Enterainment"
        frozenApp.Price = 3.99
        apps.append(frozenApp)
        
        bestNewAppCategory.apps = apps
        
        let bestNewGameCategory = AppCategory()
        bestNewGameCategory.name = "Best New Games"
        
        var bestNewGameApps = [App]()
        let telepaintApp = App()
        telepaintApp.Name = "Telepaint"
        telepaintApp.ImageName = "telepaint"
        telepaintApp.Category = "Games"
        telepaintApp.Price = 2.99
        
        bestNewGameApps.append(telepaintApp)
        
        bestNewGameCategory.apps = bestNewGameApps
        
        return [bestNewAppCategory, bestNewGameCategory]
    }
}

class App: Decodable{
    var Id: Double? //NSNumber
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Price: Double? //NSNumber
}
