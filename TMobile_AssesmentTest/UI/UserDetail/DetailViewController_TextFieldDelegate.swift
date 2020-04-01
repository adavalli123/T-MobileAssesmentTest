//
//  DetailViewController_TextFieldDelegate.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit

extension DetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.filteredRepos = DetailViewModal.filterContentForSearchText(updatedText, users: self.repos)
            searchFieldIsActive = (updatedText.isEmpty == false)
            
            self.tableView?.reloadData()
            
            return true
        }
        
        return false
    }
}
