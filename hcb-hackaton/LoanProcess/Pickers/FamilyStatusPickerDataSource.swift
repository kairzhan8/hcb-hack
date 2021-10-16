//
//  FamilyStatusPickerDataSource.swift
//  hcb-hackaton
//
//  Created by kairzhan on 16.10.2021.
//

import UIKit

final class FamilyStatusPickerDataSource: NSObject, UIPickerViewDataSource {
    var status: [String] = ["Женат/Замужем", "Холост"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        status.count
    }
}
