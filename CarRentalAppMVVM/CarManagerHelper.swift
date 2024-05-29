//
//  CarManagerHelper.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 22.05.24.
//

import Foundation
import RealmSwift




class CarManagerHelper {
    
    let items = [Car]()
    let categories = [Category]()
    let realm = try! Realm()
    
    
    func getCars() -> Results<Car> {
        return realm.objects(Car.self)
    }
    
    func getCategories() -> Results<Category> {
        return realm.objects(Category.self)
    }
    
    func getCarsCount(for categoryId: Int) -> Int {
        return realm.objects(Car.self).filter("categoryId == %@", categoryId).count
    }
    
}


