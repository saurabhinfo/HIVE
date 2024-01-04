//
//  CustomTableViewCell.swift
//  HIVE
//
//  Created by Saurabh Sharma on 03/01/24.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet private weak var customImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    // MARK: - Public Methods

    func configure(withTitle title: String, subtitle: String?, imageURL: URL?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle

        // Load the image asynchronously if imageURL is provided
        if let imageURL = imageURL {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.customImageView.image = UIImage(data: imageData)
                    }
                }
            }
        } else {
            // Clear the image if no imageURL is provided
            customImageView.image = nil
        }
    }
}
