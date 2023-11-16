//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by kenny on 11/16/23.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?

    var statusText: String {
        return scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }

    var statusTextColor: Color {
        return scannedCode.isEmpty ? .red : .green
    }

    func updateScannedCode(_ newCode: String) {
        DispatchQueue.main.async {
            self.scannedCode = newCode
        }
    }

    func updateAlertItem(_ newAlertItem: AlertItem) {
        DispatchQueue.main.async {
            self.alertItem = newAlertItem
        }
    }
}
