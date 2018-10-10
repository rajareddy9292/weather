//
//  MainVC.swift
//  weather
//
//  Created by RajaReddy  on 10/10/2018.
//   Copyright © 2018 AdtechCorp. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var container: UIView!
    
    var weatherTableView: WeatherTableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the container
        weatherTableView = Bundle.main.loadNibNamed("WeatherTableView", owner: nil, options: nil)?[0] as? WeatherTableView
        container.addSubview(weatherTableView!)
        weatherTableView!.frame = container.bounds

        // To initialise the pull-down-to-refresh from here
        weatherTableView!.initRefreshControl(mainVC: self)

        downloadData()
    }
    
    func downloadData() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        // Download the data from OpenWeatherMap
        ApiHandler.getForecast { (status, error) in

            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            if (error == nil) {
                self.weatherTableView?.reloadData()
                
            } else {

                // If there's an error, let's display the message here
                let alert = UIAlertController()
                alert.title = "Check your API Key & Network!"
                alert.message = error?.localizedDescription
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)

            }
    
        }

    }

    func tableViewRefreshRequested() {
        downloadData()
    }

}

