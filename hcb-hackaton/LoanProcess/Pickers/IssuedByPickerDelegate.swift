//
//  IssuedByPickerDelegate.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

final class IssuedByPickerDelegate: NSObject, UIPickerViewDelegate {
    var selectedType = ""
    var types: [String] = ["МВД РК", "МВД РФ"]

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = types[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
}

