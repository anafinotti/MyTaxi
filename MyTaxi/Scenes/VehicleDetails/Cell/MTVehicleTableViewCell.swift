//
//  MTVehicleTableViewCell.swift
//  MyTaxi
//
//  Created by Ana Finotti on 14/02/21.
//

import UIKit

class MTVehicleTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var buttonNavigate: UIButton!
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Layout
}
