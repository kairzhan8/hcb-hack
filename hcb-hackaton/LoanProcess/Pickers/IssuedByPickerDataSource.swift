//
//  IssuedByPickerDataSource.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

final class IssuedByPickerDataSource: NSObject, UIPickerViewDataSource {
    var types: [String] = ["МВД РК", "МВД РФ"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        types.count
    }
}
