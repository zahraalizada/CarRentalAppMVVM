//
//  HomeController.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 18.05.24.
//

import UIKit
import RealmSwift

class HomeController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var carCollectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    //  var searchCallback: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        if let url = viewModel.manager.realm.configuration.fileURL {
            print(url)
        }
        
        carCollectionView.register(UINib(nibName: "\(HeaderReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderReusableView.self)")
        carCollectionView.register(UINib(nibName: "CarCell", bundle: nil), forCellWithReuseIdentifier: "CarCell")
        
        viewModel.cars = viewModel.manager.getCars()
        viewModel.categories = viewModel.manager.getCategories()
        
        if let firstCategory = viewModel.categories?.first {
            viewModel.selectedCategoryId = firstCategory.id
        }
        
        viewModel.filterCarsByCategory()
        carCollectionView.reloadData()
    }
    
    @IBAction func searchFieldTapped(_ sender: Any) {
        if let searchText = searchField.text {
            viewModel.filterCarsBySearchText(searchText)
            carCollectionView.reloadData()
            //            viewModel.searchCallback?(searchText)
            //            mainCollectionView.reloadData()
        }
    }
    
    @IBAction func searchTappedButton(_ sender: Any) {
        if let searchText = searchField.text {
            viewModel.filterCarsBySearchText(searchText)
            carCollectionView.reloadData()
            //            mainCollectionView.reloadData()
            //            viewModel.searchCallback?(searchText)
        }
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case carCollectionView:
            return viewModel.cars?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case carCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CarCell.self)", for: indexPath) as! CarCell
            let car = viewModel.cars?[indexPath.item]
            cell.configure(title: car?.title ?? "",
                           subtitle: car?.subtitle ?? "",
                           price: "$\(car?.price ?? "")",
                           engine: car?.engine ?? "",
                           image: car?.image ?? "")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderReusableView.self)", for: indexPath) as! HeaderReusableView
        header.headerCallback = { category in
            self.viewModel.selectedCategoryId = category.id
            self.viewModel.filterCarsByCategory()
            self.carCollectionView.reloadData()
        }
        header.mainCollectionView.reloadData()
        return header
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == carCollectionView {
            return CGSize(width: collectionView.frame.width - 20, height: 350)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 300)
    }
}

