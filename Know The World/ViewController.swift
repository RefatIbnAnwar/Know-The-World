//
//  ViewController.swift
//  Know The World
//
//  Created by MySoftheaven BD on 31/12/17.
//  Copyright © 2017 MySoftheaven BD. All rights reserved.
//

import UIKit

//struct ActorInformation: Decodable {
//    let name : String?
//    let description : String?
//    let dob : String?
//    let country : String?
//    let image : String?
//}

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var mainTableView: UITableView!
//    var actors = ActorInformation
    var actorsName = [String]()
    var actorsImageStrings = [String]()
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.fetchingDataWithAPI { fetchedData in

            for actor in fetchedData {
                let actorInfo = actor as! [String: String]
                self.actorsName.append(actorInfo["name"]!)
                self.actorsImageStrings.append(actorInfo["image"]!)
            }
            
            print(self.actorsName.count)
            print(self.actorsName)
            print(self.actorsImageStrings)
           // DispatchQueue.main.async {
                self.mainTableView.reloadData()
            //}
        }
        
        
    }
    
    
    
    func fetchingDataWithAPI(completion:   @escaping (_ success: [Any]) -> Void ){
        guard let url = URL(string: "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors") else {
            fatalError()
        }
        print(url)
        print("this is inside ")
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print("this is data")
                print(data)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    let infoArray = json["actors"] as! [Any]
                    DispatchQueue.main.async {
                         completion(infoArray)
                    }
                   
                    
                    
                    
                } catch{
                    print("this is error section")
                    print(error)
                }
            }
            
            
            }.resume()
    }
    
//    func loadImageUsingUrlString(urlString: String) -> UIImage? {
//        guard let url = URL(string: urlString) else {print("url of pic cant be generated");return nil}
//
//        let session = URLSession.shared
//        session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//
//            if let data = data {
//                print("this is data")
//                print(data)
//
//
//                guard let image = UIImage(data: data) else {
//                    print("data cant be converted to image")
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//
//            }
//
//
//            }.resume()
//        return self.image
//    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actorsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "cellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as! mainTableViewCell
        cell.countryNameLabel.text = actorsName[indexPath.row]
        
        let imageURL = URL(string: actorsImageStrings[indexPath.row])
        
        if imageURL != nil{
            
            let data = try! Data(contentsOf: imageURL!)
            cell.countryImageOutlet.image = UIImage(data: data)
            
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}


