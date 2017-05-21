//
//  ToDoItemTableViewCell.swift
//  ToDoListApp
//
//  Created by Kirill Kirikov on 5/14/17.
//  Copyright © 2017 GoIT. All rights reserved.
//

import UIKit

protocol ToDoItemTableViewCellDelegate {
    func titleDidChanged(in cell:ToDoItemTableViewCell)
    func priorityDidChanged(in cell:ToDoItemTableViewCell)
}



class ToDoItemTableViewCell: UITableViewCell, UITextFieldDelegate {

    
    @IBAction func priorityButton(_ sender: UIButton) {
        
        delegate?.priorityDidChanged(in: self)
    }
    @IBOutlet weak var priorityButton: UIButton!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var delegate:ToDoItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        //priorityButton.layer.cornerRadius = 5
        titleTextField.delegate = self
        print("awakeFromNib")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    //MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        delegate?.titleDidChanged(in: self)
        
    }
    
  
    
}
