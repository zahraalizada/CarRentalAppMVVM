//
//  HomeViewModel.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 26.05.24.
//

import UIKit
import RealmSwift

class HomeViewModel {
    
    let manager = CarManagerHelper()
    var cars: Results<Car>?
    var categories: Results<Category>?
    var selectedCategoryId: Int?
    
//    var searchCallback: ((String) -> Void)?
    
    init() {
        cars = manager.getCars()
    }
    
    func filterCarsByCategory() {
        if let categoryId = selectedCategoryId {
            cars = manager.getCars().filter("categoryId == %@", categoryId)
        } else {
            cars = manager.getCars()
        }
    }
    
    func filterCarsBySearchText(_ searchText: String) {
           if searchText.isEmpty {
               filterCarsByCategory()
           } else {
               cars = manager.getCars().filter("title CONTAINS[c] %@", searchText)
           }
       }
}
