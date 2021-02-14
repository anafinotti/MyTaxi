//
//  MTMapAdapter.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import Foundation
import Pulley

class MTMapAdapter: NSObject {
    
    let delegate: MTMapProtocol
    
    //MARK: Constructor
    init(delegate: MTMapProtocol) {
        
        self.delegate = delegate
    }
}

//MARK: TableView Datasource
extension MTMapAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

//MARK: TableView Delegate
extension MTMapAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

//MARK: Pulley Delegate
extension MTMapAdapter: PulleyPrimaryContentControllerDelegate {
    
    
}
