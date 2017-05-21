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

private class TodoItemsDataSource: NSObject, UITableViewDataSource, ToDoItemTableViewCellDelegate {
    
    fileprivate var items:[ToDoItem] = []
    weak var tableView:UITableView?
    
    init(tableView:UITableView) {
        super.init()
        self.tableView = tableView
        load()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NumberOfRowsInSetion: \(section)")
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("CellForRowAt: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ToDoItemTableViewCell
        
        cell.titleTextField.text = items[indexPath.row].title
        cell.priorityButton.backgroundColor = items[indexPath.row].priority.color()
        cell.iconImageView.image = items[indexPath.row].icon
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
        self.items.remove(at: indexPath.row)
        self.tableView?.deleteRows(at: [indexPath], with: .fade)
         save()
        }
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
        tableView?.reloadData()
    }
    
    
    func addItem(item: ToDoItem) {
        items.append(item)
        save()
    }
    
    func load() {
        guard let loadedData = NSKeyedUnarchiver.unarchiveObject(withFile: "/Users/juliya/Desktop/todolistapp_updated/ToDoList.bin") as? [ToDoItem] else {
            return
        }
        items = loadedData
    }
    
    func save() {
        let result = NSKeyedArchiver.archiveRootObject(items, toFile: "/Users/juliya/Desktop/todolistapp_updated/ToDoList.bin")
        print("Archive Result: \(result)")
    }
}

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: TodoItemsDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource =  TodoItemsDataSource(tableView: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewClassworkItem(_ sender: UIButton) {
        let item = ClassworkToDoItem(title: "New Item", priority: .high)
        dataSource?.addItem(item: item)
        tableView.reloadData()
    }
}













