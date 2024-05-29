//
//  Car.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 26.05.24.
//

import Foundation
import RealmSwift


class Car: Object {
    @Persisted var id: Int
    @Persisted var categoryId: Int
    @Persisted var title: String
    @Persisted var subtitle: String
    @Persisted var engine: String
    @Persisted var price: String
    @Persisted var image: String
}
