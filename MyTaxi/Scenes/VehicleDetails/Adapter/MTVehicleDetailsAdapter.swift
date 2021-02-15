//
//  MTVehicleDetailsAdapter.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import Foundation
import Pulley

class MTVehicleDetailsAdapter: NSObject {
    
    let delegate: MTVehicleDetailsProtocol
    
    //MARK: Constructor
    init(delegate: MTVehicleDetailsProtocol) {
        
        self.delegate = delegate
    }
}

//MARK: TableView Datasource
extension MTVehicleDetailsAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return delegate.retrieveNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MTVehicleTableViewCell", for: indexPath) as! MTVehicleTableViewCell
        
        return cell
    }
}

//MARK: TableView Delegate
extension MTVehicleDetailsAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
