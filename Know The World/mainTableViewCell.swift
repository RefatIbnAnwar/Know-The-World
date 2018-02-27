//
//  mainTableViewCell.swift
//  Know The World
//
//  Created by MySoftheaven BD on 3/1/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var countryImageOutlet: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
    func loadImageUsingUrlString(urlString: String, completion: @escaping (_ success: UIImage) -> Void  )  {
        guard let url = URL(string: urlString) else {print("url of pic cant be generated");return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print("this is data")
                print(data)
                //self.image = UIImage(data: data)
//                DispatchQueue.main.async {
//                    self.image = UIImage(data: data)
//                }
                guard let image = UIImage(data: data) else {
                    print("data cant be converted to image")
                    return
                }
                completion(image)
                
            }
            
            
            }.resume()
    }
}

