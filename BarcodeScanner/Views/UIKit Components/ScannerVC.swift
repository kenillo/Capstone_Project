//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by kenny on 11/15/23.
//

import UIKit
import AVFoundation

enum CameraError: String {
    case invalidDeviceInput
    case invalidScannedValue
}

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}

final class ScannerVC: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate!
    
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                self.scannerDelegate?.didSurface(error: .invalidDeviceInput)
                return
            }
            
            let videoInput: AVCaptureDeviceInput
            
            do {
                try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                self.scannerDelegate?.didSurface(error: .invalidDeviceInput)
                return
            }
            
            if self.captureSession.canAddInput(videoInput) {
                self.captureSession.addInput(videoInput)
            } else {
                self.scannerDelegate?.didSurface(error: .invalidDeviceInput)
                return
            }
            
            let metaDataOutput = AVCaptureMetadataOutput()
            
            if self.captureSession.canAddOutput(metaDataOutput) {
                self.captureSession.addOutput(metaDataOutput)
                metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
            } else {
                self.scannerDelegate?.didSurface(error: .invalidDeviceInput)
                return
            }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer!.videoGravity = .resizeAspectFill
            
            DispatchQueue.main.async {
                self.view.layer.addSublayer(self.previewLayer!)
            }
            
            self.captureSession.startRunning()
        }
    }
}


extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        
        // captureSession.stopRunning()
        scannerDelegate?.didFind(barcode: barcode)
    }
}
