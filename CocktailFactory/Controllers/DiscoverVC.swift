//
//  ViewController.swift
//  CocktailFactory
//
//  Created by David Todua on 06.09.21.
//

import UIKit
import Alamofire

class DiscoverVC: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var randomTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var TableCategoryLabel: UILabel!
    
    private var imageLoader = ImageLoader()
    
    private var isRandom:Bool = true
    
    private let cocktailServices = CocktailServices.init()
    private var randomCocktails: [Cocktail] = []
    private var backupCocktails:[Cocktail] = []
    private var backupCategory:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomTableView.dataSource = self
        randomTableView.delegate = self
        randomTableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "CocktailTableViewCell")
        searchBar.delegate = self
        fetchRandoms()
        spinner.stopAnimating()
        
    }
    

   
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomCocktails.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = randomTableView.dequeueReusableCell(withIdentifier: "CocktailTableViewCell") as! CocktailTableViewCell
        
        var currCocktail = randomCocktails[indexPath.row]
        cell.cocktailNameLabel.text = currCocktail.strDrink
        cell.categoryLabel.text = currCocktail.strCategory
        cell.alcoholicLabel.text = currCocktail.strAlcoholic
        
        if (!isRandom && TableCategoryLabel.text != "") {
            
            cell.categoryLabel.text = TableCategoryLabel.text?.substring(to: (TableCategoryLabel.text?.index(before: (TableCategoryLabel.text?.endIndex)!))!)
        }
        
        
        let url = URL(string: currCocktail.strDrinkThumb!)!
        let token = imageLoader.loadImage(url) { result in
          do {
            // 2
            let image = try result.get()
            // 3
            DispatchQueue.main.async {
              cell.avatarImage.image = image
            }
          } catch {
            // 4
            print(error)
          }
        }
        
        cell.onReuse = {
            if let token = token {
                self.imageLoader.cancelLoad(token)
            }
        }
        
        
        
//        if currCocktail.image == nil  {
//            if let imageUrl = currCocktail.strDrinkThumb {
//                getImageFromUrl(url: imageUrl, imageView: cell.avatarImage, index: indexPath.row)
//            }
//        } else {
//            cell.avatarImage.image = currCocktail.image
//        }
        return cell
    }

    
    private func fetchRandoms() {
        spinner.startAnimating()
        for x in 0...10 {
            cocktailServices.getRandomCocktail { (sucess,object) in
                if sucess {
                    var cocktail = (object as! Cocktails).drinks[0]
                    
//                    let url = cocktail.strDrinkThumb!
//                    AF.request(url).response { (response) in
//                        if response.data != nil {
//                            let img = UIImage(data: response.data!)
//                            cocktail.image = img
//                        }
//                        if x == 9 {
//                            self.spinner.stopAnimating()
//                        }
//                    }
                    self.randomCocktails.append(cocktail)
                    self.randomTableView.reloadData()
                    if x == 9 {
                        self.spinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    
    private func fetchAndSetImage(imageUrl:String,imageView:UIImageView) {
        let request = AF.request(imageUrl)
        _ = request.response { data in
            if let imageDownloaded = UIImage(data: data.data!) {
                imageView.image = imageDownloaded
            }
        }
    }
    private func getImageFromUrl(url: String, imageView:UIImageView, index:Int, indexPath: IndexPath? = nil ) {
        
        AF.request(url).response { response in
            if let image = UIImage(data: response.data!) {
                if indexPath == nil {
                    imageView.image = image
                    if index < self.randomCocktails.count {
                        self.randomCocktails[index].image = image
                    }

                } else {
                if self.randomTableView.cellForRow(at: indexPath!) != nil {
                    (self.randomTableView.cellForRow(at: indexPath!) as! CocktailTableViewCell).avatarImage.image = image
                    }
                }
            }
        }
    }
}
extension DiscoverVC: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if (indexPath.row + 1 == randomCocktails.count && randomCocktails.count < 50 && isRandom) {
            fetchRandoms()
            
        }
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(identifier: "CocktailDetailVC") as! CocktailDetailVC
        if isRandom {
            VC.cocktail = randomCocktails[indexPath.row]
            navigationController?.pushViewController(VC, animated: true)
        } else {
            let id = randomCocktails[indexPath.row].idDrink ?? "0"
            
            cocktailServices.fetchCocktailById(id: id) { (bool,object) in
                if bool {
                    var currCocktail = (object as! Cocktails).drinks[0]
                    currCocktail.image = self.randomCocktails[indexPath.row].image
                    VC.cocktail = currCocktail
                    self.navigationController?.pushViewController(VC, animated: true)
                    

                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    
}


extension DiscoverVC {
    //MARK: - CategoryButtonsPressed
    
    
    @IBAction func cocktailButtonPressed(_ sender: UIButton) {
        let category = "cocktail"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Cocktails"

    }
    @IBAction func beerButtonPressed(_ sender: UIButton) {
        let category = "beer"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Beers"

    }
    @IBAction func ordinaryDrinkButtonPressed(_ sender: UIButton) {
        let category = "ordinary%20drink"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Ordinary Drink"
    }
    @IBAction func sodaButtonPressed(_ sender: UIButton) {
        let category = "soft%20drink%20/%20soda"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Sodas"

    }
    @IBAction func shotButtonPressed(_ sender: UIButton) {
        let category = "shot"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Shots"

    }
    @IBAction func homemadeButtonPressed(_ sender: UIButton) {
        let category = "homemade%20liqueur"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Homemade Liqueurs"

    }
    @IBAction func punchButtonPressed(_ sender: UIButton) {
        let category = "punch%20/%20party%20drink"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Party Drinks"

    }
    @IBAction func coffeOrTeaButtonPressed(_ sender: UIButton) {
        let category = "Coffee%20/%20Tea"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Coffe And Tea "

    }
    @IBAction func milkshakeButtonPressed(_ sender: UIButton) {
        let category = "milk%20/%20float%20/%20shake"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Milkshakes"

    }
    @IBAction func otherButtonPressed(_ sender: UIButton) {
        let category = "other/unknown"
        getCocktails(category: category)
        
        TableCategoryLabel.text = "Unnamed Ones"
        

    }
    
    private func getCocktails( category:String ) {
        spinner.startAnimating()
        cocktailServices.getCocktailsByCategory(givenCategory: category) { (success,object) in
            if success {
                self.fetchedCategoryCocktailsHandler(object: object!,category: category )
            }
        }
    }
    
    private func fetchedCategoryCocktailsHandler(object:AnyObject, category:String) {
        isRandom = false
        
        let cocktails = (object as! Cocktails)
        randomCocktails = cocktails.drinks
        randomTableView.reloadData()
        self.spinner.stopAnimating()
    }
}

extension DiscoverVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text == "") {
            return
        }
        backupCocktails = randomCocktails
        backupCategory = TableCategoryLabel.text!
        
        let searchCocktailName = prepareString(starter: searchBar.text!)
        let cocktailName2 = searchBar.text
        CocktailServices.init().fetchCocktailsByUsername(username: searchCocktailName) { (bool,object) in
            let result = (object as! Cocktails).drinks
            self.TableCategoryLabel.text = cocktailName2
            self.isRandom = false
            self.randomCocktails = result
            self.randomTableView.reloadData()
        }
    }
    private func prepareString(starter:String)->String {
        var result:String = ""
        for char in starter {
            if char == " " {
                result.append("%20")
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            randomCocktails = backupCocktails
            TableCategoryLabel.text = backupCategory
            randomTableView.reloadData()
        }
    }
}





