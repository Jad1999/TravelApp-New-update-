//
//  ViewController.swift
//  TravelApp
//
//  Created by Jad ghoson on 28/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var allButton: UIButton!
    
    
    @IBOutlet weak var beachButton: UIButton!
    
    
    @IBOutlet weak var mountainButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var forestButton: UIButton!
    
    
    var info = DataBase.data
    var filterInfo = [Info]()//this value to put the data after filtring the Array
    var isSearching = false
    
    
    //type of Data for the Filters
    var filterBeach = [Info]()
    var filterMountain = [Info]()
    var filterForest = [Info]()
    
    
    
    
    
    //Toggle List of Filters
    var beachFilter = false
    var mountainFilter = false
    var forestFilter = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.dataSource = self//this for display the DataSource
        tableView.delegate = self
        tableView.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomiseCell")
        tableView.rowHeight = 200
        tableView.backgroundColor = UIColor.opaqueSeparator//to make the TV same like View wen we scroll down
        
        
        
        //SearchBar
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.placeholder = "Search"
        
        //Button editing
        beachButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        beachButton.backgroundColor = UIColor.white
        beachButton.layer.borderColor = UIColor.black.cgColor
        beachButton.layer.borderWidth = 0.5
        beachButton.layer.cornerRadius = beachButton.bounds.width / 5
        beachButton.clipsToBounds = true
        
        forestButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        forestButton.backgroundColor = UIColor.white
        forestButton.layer.borderColor = UIColor.black.cgColor
        forestButton.layer.borderWidth = 0.5
        forestButton.layer.cornerRadius = forestButton.bounds.width / 7
        forestButton.clipsToBounds = true
        
        mountainButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        mountainButton.backgroundColor = UIColor.white
        mountainButton.layer.borderColor = UIColor.black.cgColor
        mountainButton.layer.borderWidth = 0.5
        mountainButton.layer.cornerRadius = mountainButton.bounds.width / 7
        mountainButton.clipsToBounds = true
        
        
        
        allButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        allButton.backgroundColor = UIColor.white
        allButton.layer.borderColor = UIColor.black.cgColor
        allButton.layer.borderWidth = 0.5
        allButton.layer.cornerRadius = allButton.bounds.width / 5
        allButton.clipsToBounds = true
        
        
        
        
    }
    //MARK: The func of the Button of Filters
    
    @IBAction func allButton(_ sender: UIButton) {
        restFilters()
        tableView.reloadData()
    }
    
    @IBAction func beachButton(_ sender: UIButton) {
        restBeachFilter()
        beachFilter.toggle()
        tableView.reloadData()
    }
    
    @IBAction func mountainButton(_ sender: UIButton) {
        restMountainFilter()
        mountainFilter.toggle()
        tableView.reloadData()
        
    }
    
    
    @IBAction func forestButton(_ sender: UIButton) {
       restForestFilter()
        forestFilter.toggle()
        tableView.reloadData()
    }
    

}
//MARK: - Data Source For TableView

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         filterBeach = info.filter{$0.special.hasPrefix("Summer")}
         filterMountain = info.filter {$0.special.hasPrefix("Mountain") }
         filterForest = info.filter{ $0.special.hasPrefix("Forest") }
        
        if beachFilter == true{
            return filterBeach.count
        }else if  mountainFilter == true{
            return filterMountain.count
        }
        else if forestFilter == true{
            return filterForest.count
        }else{
            return isSearching ? filterInfo.count : info.count
        }
}
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             filterMountain = info.filter {$0.special.hasPrefix("Mountain") }
             filterBeach = info.filter{$0.special.hasPrefix("Summer")}
             filterForest = info.filter{ $0.special.hasPrefix("Forest") }
            
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomiseCell", for: indexPath) as! CellTableViewCell
            
            var item = info[indexPath.row]
            
            if beachFilter == true{
                item = filterBeach[indexPath.row]
            }else if mountainFilter == true{
                item = filterMountain[indexPath.row]
            }else if forestFilter == true {
                item = filterForest[indexPath.row]
            }else{
                item = isSearching ? filterInfo[indexPath.row] : info[indexPath.row]
            }
            
           
            cell.titleLabel?.text = item.title
            cell.bodyLabel?.text = item.body
            cell.priceLabel?.text = item.price
            cell.reviewsLabel?.text = String(item.review)
            cell.containerImageView?.image = item.image
            
            return cell
            
        }
     
    
    
    }

//MARK: - UISearch Bar

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearching = false
            tableView.reloadData()
        }else{
            isSearching = true
            filterInfo = info.filter{ $0.title.lowercased().contains(searchText.lowercased())}
            tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
//MARK: Delegate Methods
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello")
        performSegue(withIdentifier: "MoreDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            
            if beachFilter == true{
                destinationVC.selectedCell = filterBeach[indexPath.row]
            } else if  mountainFilter == true {
                destinationVC.selectedCell = filterMountain[indexPath.row]
            }else if forestFilter == true {
                destinationVC.selectedCell = filterForest[indexPath.row]
            }else{
                destinationVC.selectedCell = filterInfo[indexPath.row]
            }
            
          
        }
    }
    //MARK: The Func of Rest Filters
    func restFilters(){
         beachButton.backgroundColor = UIColor.white
         mountainButton.backgroundColor = UIColor.white
         forestButton.backgroundColor = UIColor.white
         allButton.backgroundColor = UIColor.green
          beachFilter = false
          mountainFilter = false
          forestFilter = false
     }
    func restBeachFilter(){
        beachButton.backgroundColor = UIColor.green
        mountainButton.backgroundColor = UIColor.white
        forestButton.backgroundColor = UIColor.white
        allButton.backgroundColor = UIColor.white
        mountainFilter = false
        forestFilter = false
        
    }
    func restMountainFilter(){
        beachButton.backgroundColor = UIColor.white
        mountainButton.backgroundColor = UIColor.green
        forestButton.backgroundColor = UIColor.white
        allButton.backgroundColor = UIColor.white
        beachFilter = false
        forestFilter = false
        
    }
    func restForestFilter(){
        beachButton.backgroundColor = UIColor.white
        mountainButton.backgroundColor = UIColor.white
        forestButton.backgroundColor = UIColor.green
        allButton.backgroundColor = UIColor.white
        mountainFilter = false
        beachFilter = false
        
    }

}

