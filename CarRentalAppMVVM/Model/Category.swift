//
//  Category.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 26.05.24.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var image: String
}
