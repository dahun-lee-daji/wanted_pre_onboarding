//
//  MainWeatherViewController.swift
//  WeatherInfo
//
//  Created by 이다훈 on 2022/06/09.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    private var viewModel: MainWeatherViewModel!
    private var dataSource: UICollectionViewDiffableDataSource<Int, SimpleWeatherInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setDataSource()
        weatherCollectionView.delegate = self
        
        viewModel.loadData {
            DispatchQueue.main.async { [unowned self] in
                bind()
            }
        }
        
    }
    
    func setLayout() {
        let margin = 2.0
        let itemSize = NSCollectionLayoutSize
            .init(widthDimension: .fractionalHeight(1.0),
                  heightDimension: .fractionalHeight(1.0))
        
        
        let item = NSCollectionLayoutItem.init(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: margin,
            leading: margin,
            bottom: margin,
            trailing: margin)
        
        
        let groupSize = NSCollectionLayoutSize
            .init(widthDimension: .fractionalWidth(0.5),
                  heightDimension: .fractionalHeight(1.0))
        let leadingGroup = NSCollectionLayoutGroup
            .vertical(layoutSize: groupSize, subitem: item,
                      count: 1)
        
        let trailingGroup = NSCollectionLayoutGroup
        .vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)), subitems: [leadingGroup, trailingGroup])
        
        let section = NSCollectionLayoutSection(group: horizontalGroup)

        let layout = UICollectionViewCompositionalLayout(section: section)
        weatherCollectionView.collectionViewLayout = layout
    }
    
    func setDataSource() {
        dataSource = .init(collectionView: weatherCollectionView) { collectionView, indexPath, itemIdentifier -> UICollectionViewCell in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainWeatherCollectionViewCell", for: indexPath) as? MainWeatherCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: itemIdentifier)
            self.viewModel.getImageData(id: itemIdentifier.icon) { data in
                DispatchQueue.main.async {
                    cell.iconImageView.image = UIImage.init(data: data)
                }
            }
            
            return cell
        }
    }
    
    func bind() {
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, SimpleWeatherInfo>()
        
        viewModel.data.bind({ [unowned self] data in
            let simples = data.compactMap({$0.toSimple()})
            snapShot.appendSections([0])
            snapShot.appendItems(simples)
            self.dataSource.apply(snapShot,
                                  animatingDifferences: true)
        })
    }

}

extension MainWeatherViewController: StoryboardInitiative {
    static func create(with: MainWeatherViewModel) -> Self {
        let vc = self.initiate(nil)
        vc.viewModel = with
        return vc
    }
    
}

extension MainWeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MainWeatherCollectionViewCell else {
            return
        }
        
        viewModel.selectedItem(id: cell.id)
    }
}

