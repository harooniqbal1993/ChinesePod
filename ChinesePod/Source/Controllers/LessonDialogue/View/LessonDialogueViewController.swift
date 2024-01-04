//
//  LessonDialogueViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 01/01/2024.
//

import UIKit

class LessonDialogueViewController: UIViewController {
    
    @IBOutlet weak var dialogueTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        dialogueTable.delegate = self
        dialogueTable.dataSource = self
        
        dialogueTable.register(UINib(nibName: "DialogueCell", bundle: nil), forCellReuseIdentifier: "DialogueCell")
    }
}

extension LessonDialogueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DialogueCell", for: indexPath) as! DialogueCell
        cell.onTap = {
            let indexPath = IndexPath(item: indexPath.row, section: 0)
            self.dialogueTable.reloadRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: DialogueCell = tableView.cellForRow(at: indexPath)! as! DialogueCell
        cell.toggleViews()
        let indexPath = IndexPath(item: indexPath.row, section: 0)
        self.dialogueTable.reloadRows(at: [indexPath], with: .fade)
    }
}
