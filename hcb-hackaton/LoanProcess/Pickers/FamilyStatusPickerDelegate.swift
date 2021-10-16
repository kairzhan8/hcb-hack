//
//  FamilyStatusPickerDelegate.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

final class FamilyStatusPickerDelegate: NSObject, UIPickerViewDelegate {
    var selectedStatus = ""
    var status: [String] = ["Женат", "Холост"]

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStatus = status[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]
    }
}
