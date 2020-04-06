//
//  HomeViewController.swift
//  RequestsTask
//
//  Created by Seif Elmenabawy on 4/6/20.
//  Copyright © 2020 Seif Elmenabawy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func fetchSwiftLogoTapped(_ sender: Any) {
        fetchImageAndDisplay(URLString: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/40px-Swift_logo.svg.png")
    }
    
    @IBAction func fetchDogImageTapped(_ sender: Any) {
        getRandomDogImage()
    }
    
    
    
    func getRandomDogImage(){
        //let url = URL(string: "https://dog.ceo/api/breeds/image/random")
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/40px-Swift_logo.svg.png")
        
        
        let randomImageTask = URLSession.shared.dataTask(with: url!) {data, httpresponse, error in
            print("Fetch dog link request completed")
            if let error = error{
                print("Fetch Dog Link Error: ",error.localizedDescription)
                return
            }
            
            if let data = data{
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    let imageLink = self.parseDogLink(jsonData: responseJSON)
                    if let imageLink = imageLink {
                        self.fetchImageAndDisplay(URLString: imageLink)
                    }    
                }
                else{
                    print("Couldn't parse image url")
                    return
                }
            } else{
                print("Returned data is nil")
                return
            }
            
        }
        
        randomImageTask.resume()
        print("Fetch dog link requested")
        
    }
    
    
    func fetchImageAndDisplay(URLString: String){
        let url = URL(string: URLString)
        
        let dogImageTask = URLSession.shared.dataTask(with: url!) {data, httpresponse, error in
            print("Fetch image request completed")
            if let error = error{
                print("Fetch Image Error: ",error.localizedDescription)
                return
            }
            
            if let data = data{
                DispatchQueue.main.async {self.imageView.image = UIImage.init(data: data)}
                
            } else{
                print("Returned data is nil")
                return
            }
            
        }
        
        dogImageTask.resume()
        print("Fetch image requested")
    }
    
    func parseDogLink(jsonData: [String: Any]) -> String?{
        if let dogLink = jsonData["message"] as? String{
            return dogLink
        }
        return nil
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
