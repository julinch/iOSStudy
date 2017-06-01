//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Kirill Kirikov on 5/14/17.
//  Copyright © 2017 GoIT. All rights reserved.
//

import UIKit

private enum ToDoItemPriority:Int {
    case normal
    case low
    case high
    
    func nextPriority() -> ToDoItemPriority
    {
        switch self {
        case .high:
            return .low
        case .low:
            return .normal
        case .normal:
            return .high
        }
    }
    
    
    func color() -> UIColor {
        switch self {
        case .high:
            return .red
        case .low:
            return .blue
        case .normal:
            return UIColor(red: 5/255, green: 225/255, blue: 119/255, alpha: 1)
        }
    }
}

private protocol ToDoItem {
    var title:String {
        get
        set
    }
    
    var priority:ToDoItemPriority {
        get
        set
    }
    
    var icon:UIImage {
        get
    }
}

private class BaseToDoItem: NSObject, ToDoItem, NSCoding {
    
    var icon: UIImage {
        get {
            return #imageLiteral(resourceName: "icon_0")
        }
    }
    
    var title: String
    var priority: ToDoItemPriority
    
    init(title: String, priority: ToDoItemPriority) {
        self.title = title
        self.priority = priority
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        self.priority = ToDoItemPriority(rawValue: aDecoder.decodeInteger(forKey: "priority"))!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(priority.rawValue, forKey: "priority")
    }
}

private class ClassworkToDoItem: BaseToDoItem {
    override var icon: UIImage {
        get {
            return #imageLiteral(resourceName: "icon_2")
        }
    }
}

private class HomeworkToDoItem: BaseToDoItem {
    override var icon: UIImage {
        get {
            return #imageLiteral(resourceName: "icon_0")
        }
    }
}

private class GameToDoItem: BaseToDoItem {
    override var icon: UIImage {
        get {
            return #imageLiteral(resourceName: "icon_1")
        }
    }
}


class ViewController: UITableViewController {


       @IBOutlet override var tableView: UITableView!
    {
        get { return super.tableView}
        set {super.tableView = newValue}
        
    }
    //table view outlet
    
  
    
    fileprivate var items:[ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   
    @IBAction func addNewItem(_ sender: UIButton) {
        let alert = UIAlertController(title: "Create New Item", message: "What kind of item do you want to create?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Classwork", style: .default, handler: { (action:UIAlertAction) in
            self.addItem(item: ClassworkToDoItem(title: "", priority: .normal))
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Homework", style: .default, handler: { (action:UIAlertAction) in
            self.addItem(item: HomeworkToDoItem(title: "", priority: .normal))
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Game", style: .default, handler: { (action:UIAlertAction) in
            self.addItem(item: GameToDoItem(title: "", priority: .normal))
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    }
   

extension ViewController//: UITableViewDelegate, UITableViewDataSource 
    {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         //guard let cell = tableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NumberOfRowsInSetion: \(section)")
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        let item = items[indexPath.row].title
        let alert = UIAlertController(title: "Are you sure?", message: "Do you want to delete \(item)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.items.remove(at: indexPath.row)
            self.tableView?.deleteRows(at: [indexPath], with: .fade)
            self.save()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    fileprivate  func addItem(item: ToDoItem) {
        items.append(item)
        save()
    }
    
    fileprivate func load() {
        guard let loadedData = NSKeyedUnarchiver.unarchiveObject(withFile: "/Users/juliya/Documents/iOSStudy/todolistapp_Homework_Linchevskaya#3/ToDoList.bin") as? [ToDoItem] else {
            return
        }
        items = loadedData
    }
    
    fileprivate func save() {
        let result = NSKeyedArchiver.archiveRootObject(items, toFile: "/Users/juliya/Documents/iOSStudy/todolistapp_Homework_Linchevskaya#3/ToDoList.bin")
        print("Archive Result: \(result)")
    }

}

extension ViewController: ToDoItemTableViewCellDelegate {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("CellForRowAt: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ToDoItemTableViewCell
        
        cell.titleTextField.text = items[indexPath.row].title
        cell.priorityButton.backgroundColor = items[indexPath.row].priority.color()
        cell.iconImageView.image = items[indexPath.row].icon
        cell.delegate = self
        
        return cell
    }
    func titleDidChanged(in cell:ToDoItemTableViewCell) {
        guard let index = tableView?.indexPath(for: cell) else {
            return
        }
        
        items[index.row].title = cell.titleTextField?.text ?? ""
        save()
    }
    
    func priorityDidChanged(in cell: ToDoItemTableViewCell) {
        guard let index = tableView?.indexPath(for: cell) else {
            return
        }
        items[index.row].priority = items[index.row].priority.nextPriority()
        save()
        tableView?.reloadData()
    }
}









