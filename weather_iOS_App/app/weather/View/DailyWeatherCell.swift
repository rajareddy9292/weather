//
//  DailyWeatherCell.swift
//  weather
//
//  Created by RajaReddy  on 10/10/2018.
//   Copyright © 2018 AdtechCorp. All rights reserved.
//

import UIKit

class DailyWeatherCell : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherSamples: [WeatherSample] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        let nibName = UINib(nibName: "SampleViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "SampleViewCell")
    }
    
    func setWeatherSamples(weatherSamples: [WeatherSample]) {
        self.weatherSamples = weatherSamples
        collectionView.reloadData()

        if (weatherSamples.count > 0) {
            label.text = weatherSamples[0].dateString(format: "dd MMMM YYYY")
        }
    }
    
    /**
     UICollectionView
     */

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleViewCell", for: indexPath) as! SampleViewCell
        
        let weatherSample = weatherSamples[indexPath.row]
        cell.setWeatherSample(weatherSample: weatherSample)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherSamples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
    
}
