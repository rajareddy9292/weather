//
//  WeatherTableView.swift
//  weather
//
//  Created by RajaReddy  on 10/10/2018.
//   Copyright © 2018 AdtechCorp. All rights reserved.
//

import UIKit

class WeatherTableView : UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!    

    var refreshControl: UIRefreshControl?
    
    var collection: [[WeatherSample]] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        tableView.rowHeight = 256
        let nibName = UINib(nibName: "DailyWeatherCell", bundle:nil)
        tableView.register(nibName, forCellReuseIdentifier: "DailyWeatherCell")
        
        reloadData()
    }
    
    func reloadData() {
        refreshControl?.endRefreshing()
        collection = State.sharedInstance.groupedWeatherSamples()
        tableView.reloadData()
    }

    func initRefreshControl(mainVC: MainVC) {
        if (refreshControl == nil) {
            refreshControl = UIRefreshControl()
            refreshControl?.addTarget(mainVC, action: #selector(MainVC.tableViewRefreshRequested), for: UIControlEvents.valueChanged)
            tableView.addSubview(refreshControl!)
        }
    }
    
    /**
     UITableView
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyWeatherCell
        
        let weatherSamples = collection[indexPath.row]
        cell.setWeatherSamples(weatherSamples: weatherSamples)

        return cell
    }
    
}
