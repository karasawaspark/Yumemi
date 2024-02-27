//
//  StartPageViewController.swift
//  Weather
//
//  Created by spark-03 on 2024/01/26.
//

import UIKit

class StartPageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var weatherListTableView: UITableView!
    @IBOutlet weak var firstIndicator: UIActivityIndicatorView!
    
    let weatherDatailList = WeatherDetailList()
    var areas: [WeatherResponseList] = []
    //var info:String =
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstIndicator.hidesWhenStopped = true
        
        reloadWeather()
        
        weatherListTableView.delegate = self
        
        weatherListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let weatherList = areas[indexPath.row]
        cell.textLabel?.text = weatherList.area.rawValue
        
        
        let maxTemp = weatherList.info.max_temperature
        let minTemp = weatherList.info.min_temperature
        cell.detailTextLabel?.text = "最高気温は\(maxTemp)です。最低気温は\(minTemp)です。"
        
        switch weatherList.info.weather_condition {
        case "sunny":
            cell.imageView?.image = UIImage(named: "sunny")
            cell.imageView?.tintColor = UIColor.red
        case "cloudy":
            cell.imageView?.image = UIImage(named: "cloudy")
            cell.imageView?.tintColor = UIColor.gray
        case "rainy":
            cell.imageView?.image = UIImage(named: "rainy")
            cell.imageView?.tintColor = UIColor.blue
        default:
            break
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    
    func reloadWeather() {
        //self.indicator.startAnimating()
        Task {
            let result = await weatherDatailList.yumemiWeather()
            self.firstIndicator.startAnimating()
            //   self.indicator.stopAnimating()
            switch result {
            case .success(let areas):
                self.areas = areas
                weatherListTableView.reloadData()
                self.firstIndicator.stopAnimating()
            case .failure(let error):
                self.showErrorList(alert:"Error\(error.localizedDescription)")
                self.firstIndicator.stopAnimating()
            }
        }
    }
    
    
    func showErrorList(alert: String) {
        Task{
            let alertController = UIAlertController(title: alert, message: "エラー", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            self.present(alertController, animated: false, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail",
           let indexPath = weatherListTableView.indexPathForSelectedRow,
           let destinarionDetail = segue.destination as? ViewController {
            destinarionDetail.detailAreas = areas[indexPath.row]
        }
    }
}
