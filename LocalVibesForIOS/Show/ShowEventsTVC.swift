//
//  ShowEventsTVC.swift
//  LocalVibesForIOS
//
//  Created by Bijaya Gurung on 3/8/2024.
//

import UIKit

class ShowEventsTVC: UITableViewController {

    var selectedEvent: Event!
    var service = Repository()
    var events = [Event]()
    
    @IBOutlet var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("I am inside show events!!")
        
        service.showEvents(fromCollection: "Events"){
            (returnedCollection) in
            self.events = returnedCollection
            print("inside total \(self.events.count)")
            
            // Reload the tableview
            self.eventTableView.reloadData()
        }
        
        print("total \(events.count)")
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier1", for: indexPath) as! ShowEventsTVCell

        // Configure the cell...
        
        let event = events[indexPath.row]
        cell.eventTitle.text = event.eventTitle
        cell.eventVenue.text = event.eventVenue
        cell.eventDate.text = event.eventDate
        
        cell.eventsImageView.image = UIImage(systemName: "person.circle.fill")

        return cell
    }
   
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedEvent = events[indexPath.row]
        return indexPath
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
           // tableView.deleteRows(at: [indexPath], with: .fade)
            
            let events = events[indexPath.row]
            deleteConfirmationMessage(title:"Delete",
                                      message: "Do you want to permanently delete the event?",
                                         delete: {
                if self.service.deleteEvent(withEventId: events.id){
                                                print("Event deleted")
                                                }
                                                  },
                                      cancel: {
                
                                               })
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // passing selected events data
        if let viewEventTVC = segue.destination as? ViewEventTVC {
            viewEventTVC.event = selectedEvent
        }
    }
    

    // Exiting all screens in between and reaching the destination screen
    @IBAction func unwindToShowEventsTVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
