//
//  DetailViewController.swift
//  AppleNewsFeed
//
//  Created by Edgars Jaudzems on 12/02/2021.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    //Core data
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    
    var webURLString = String()
    var titleString = String()
    var contentString = String()
    var newsImage: UIImage?
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "APPLE"
        print(webURLString)
        
        titleLabel.text = titleString
        contentTextView.text = contentString
        newsImageView.image = newsImage
        
        //Core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        // Saving to core data
        let newItem = Items(context: self.context!)
        newItem.newsTitle = titleString
        newItem.newsContent = contentString
        newItem.url = webURLString
        guard let imageData: Data = (newsImage?.pngData()) else {
            return
        }
        
        if !imageData.isEmpty {
            newItem.image = imageData
        }
        
        // Appending core data and save items
        self.savedItems.append(newItem)
        saveData()
    }
    
    // saving core data
    func saveData() {
        do {
            try context?.save()
        } catch {
            // alert
            print(error.localizedDescription)
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destination: WebViewController = segue.destination as! WebViewController
        // Pass the selected object to the new view controller.
        destination.urlString = webURLString
    }

}
