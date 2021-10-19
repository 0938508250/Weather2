
import UIKit
import Alamofire
import SwiftyJSON

class citiesVC: UITableViewController {
    @IBOutlet weak var cityTableView: UITableView!
    
    var cityName = ""
    
    struct Cities {
        var cityName = ""
        var cityTemp = 0.0
    }
    var cityTempArray: [Cities] = []
    func currentWeather(city: String){
        let url = "https://api.weatherapi.com/v1/current.json?key=8643ebe06f40429286a103654211510&q=London&aqi=\(city)"
        AF.request(url, method: .get).validate().responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = json["location"]["name"].stringValue
                let temp = json["current"]["temp_c"].doubleValue
                self.cityTempArray.append(Cities(cityName: name, cityTemp: temp))
                self.cityTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func addCityAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Добавить", message: "Введите название города", preferredStyle: .alert)
        alert.addTextField { (textField)in
            textField.placeholder = "Moscow"
        }
        let canceAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        let newCityAction = UIAlertAction(title: "Добавить", style: .default) {(action) in
            let name = alert.textFields![0].text
            self.currentWeather(city: name!)
            
        }
        alert.addAction(canceAction)
        alert.addAction(newCityAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        
        cell.cityName.text = cityTempArray[indexPath.row].cityName
        cell.cityTemp.text = String(cityTempArray[indexPath.row].cityTemp)
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        cityName = cityTempArray[indexPath.row].cityName
        performSegue(withIdentifier: "detailVC", sender:self)
    }
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        if let vc = segue.destination as? detailVC {
            vc.cityName = cityName
        }
    }
}
