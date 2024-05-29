//
//  SearchViewModel.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 26.05.24.
//

import UIKit
import RealmSwift

class SearchViewModel {
    
    let manager = CarManagerHelper()
    var cars: Results<Car>?
    
    init() {
        cars = manager.getCars()
    }
    
    func filterCarsBySearchText(_ searchText: String) {
        if searchText.isEmpty {
            cars = manager.getCars()
        } else {
            cars = manager.getCars().filter("title CONTAINS[c] %@", searchText)
        }
    }
}
