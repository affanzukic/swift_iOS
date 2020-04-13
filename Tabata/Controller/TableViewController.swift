//
//  TableViewController.swift
//  Tabata
//
//  Created by Affan Zukić on 2020-04-04.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit
import SafariServices

let settings = ["Number of sets",
                "Set length",
                "Break length",
                "Recovery length",
                "Pre-interval length",
                "Feedback",
                "Donate",
                "About"]
var myIndex = 0
var access = Settings()

class TableViewController: UITableViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return settings.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = settings[indexPath.row]
        cell.textLabel?.textColor = UIColor.link
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22.0)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        let aboutAlert = UIAlertController(title: "About", message: "This app was developed by Affan Zukic. Instagram: @zukic1", preferredStyle: .alert)
        let feedbackAlert = UIAlertController(title: "Feedback", message: "Please leave feedback at App Store", preferredStyle: .alert)
        let donateAlert = UIAlertController(title: "Donate", message: "Please consider donating, it would be helpful to improve our apps.", preferredStyle: .alert)
        
        if myIndex == 5
        {
            feedbackAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(feedbackAlert, animated: true, completion: nil)
        }
        else if myIndex == 7
        {
            aboutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(aboutAlert, animated: true, completion: nil)
        }
        else if myIndex == 0
        {
            access.setNumberName(nameToSet: settings[myIndex])
            performSegue(withIdentifier: "numberSegue", sender: self)
        }
        else if myIndex == 6
        {
            donateAlert.addAction(UIAlertAction(title: "Donate", style: .default, handler: {(action) -> Void in
                let url = URL(string: "https://paypal.me/2uk4")
                let svc = SFSafariViewController(url: url!)
                self.present(svc, animated: true, completion: nil)
                
            }))
            donateAlert.addAction(UIAlertAction(title: "Not now", style: .default, handler: nil))
            self.present(donateAlert, animated: true, completion: nil)
        }
        else
        {
            access.setLengthName(nameToSet: settings[myIndex])
            performSegue(withIdentifier: "lengthSegue", sender: self)
        }
    }
}
