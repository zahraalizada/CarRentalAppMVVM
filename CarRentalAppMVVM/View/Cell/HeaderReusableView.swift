//
//  HeaderReusableView.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 27.05.24.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var vehiclesLabel: UILabel!
    
    let viewModel = HomeViewModel()
    var headerCallback: ((Category) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        mainCollectionView.register(UINib(nibName: "MainCell", bundle: nil), forCellWithReuseIdentifier: "MainCell")
        
        viewModel.cars = viewModel.manager.getCars()
        viewModel.categories = viewModel.manager.getCategories()
        
        if let firstCategory = viewModel.categories?.first {
            viewModel.selectedCategoryId = firstCategory.id
        }
        
        viewModel.filterCarsByCategory()
    }
}

extension HeaderReusableView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCell.self)", for: indexPath) as! MainCell
        
        let category = viewModel.categories?[indexPath.item]
        let isSelected = viewModel.selectedCategoryId == category?.id
        let carCount = viewModel.manager.getCarsCount(for: category?.id ?? 0)
        
        cell.configure(image: category?.image ?? "",
                       count: "\(carCount)",
                       title: category?.name ?? "",
                       backgroundColor: isSelected ? .blue : .white)
        return cell
    }
}

extension HeaderReusableView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedCategoryId = viewModel.categories?[indexPath.item].id
        viewModel.filterCarsByCategory()
        mainCollectionView.reloadData()
        let category = viewModel.categories?[indexPath.item]
        headerCallback?(category!)
    }
}

extension HeaderReusableView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 230)
    }
}
