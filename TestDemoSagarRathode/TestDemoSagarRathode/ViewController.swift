//
//  ViewController.swift
//  TestDemoSagarRathode
//
//  Created by appbellmac on 14/05/19.
//  Copyright ©  2019 Sagar Rathode All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var placeArray = [place]()
   
    @IBOutlet weak var Listtableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Listtableview.delegate = self
        Listtableview.dataSource = self
        
            loadData()
    }
    func loadData()
    {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data : Data?, response : URLResponse?, error : Error?) in
            
            if error != nil{
                print("Unable to fetch data")
            }
            
            do{
                let rootArray = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                print(rootArray)
                
                for i in stride(from: 0, to: rootArray.count, by: 1){
                    
                    let tempObj = rootArray.object(at: i) as AnyObject
                    let tempPlaceObject = place()
                    let thumbnailUrl = tempObj.object(forKey: "thumbnailUrl") as! String
                    let title = tempObj.object(forKey: "id") as! Int
                     tempPlaceObject.thumbnailUrl = thumbnailUrl
                    tempPlaceObject.id = title
                    self.placeArray.append(tempPlaceObject)
                    
                }
                
                DispatchQueue.main.async {
                    self.Listtableview.reloadData()
                }
            }
            
        })
        
        dataTask.resume()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let temp = placeArray[indexPath.row]
        cell.lbltitle.text = String(temp.id)
        let url = URL(string: temp.thumbnailUrl)
        
        DispatchQueue.global().async {
         let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
         DispatchQueue.main.async {
               cell.img.image = UIImage(data: data!)
          }
        }
        return cell
    }

}

