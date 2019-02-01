//
//  EventTableViewCell.swift
//  AppleProject
//
//  Created by Christopher Hartanto on 26/01/19.
//  Copyright © 2019 Christopher Hartanto. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    var delegate: EventDelegate!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imageSport : [[UIImage]] = [[UIImage(named: "running1")!,UIImage(named: "running2")!,UIImage(named: "running3")!],[UIImage(named: "cycling1")!,UIImage(named: "cycling2")!,UIImage(named: "cycling3")!],[UIImage(named: "badminton1")!,UIImage(named: "badminton2")!,UIImage(named: "badminton3")!],[UIImage(named: "futsal1")!,UIImage(named: "futsal2")!,UIImage(named: "futsal3")!],[UIImage(named: "basket1")!,UIImage(named: "basket2")!,UIImage(named: "basket3")!]]
    
    
    var data: [String]!
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EventTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventRow", for: indexPath) as! EventCollectionView
        
        cell.lblName.text = self.data[indexPath.row]
        cell.ivSport.image = imageSport[index][indexPath.row]

        
        return cell
    }
    

    
}

extension EventTableViewCell : UICollectionViewDelegateFlowLayout {
    
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          //self.performSegue(withIdentifier: "toEventDetail", sender: self)
        delegate.selectedEvent(name:self.data[indexPath.row])
    }
}
