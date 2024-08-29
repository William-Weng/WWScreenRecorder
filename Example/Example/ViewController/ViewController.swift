//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/8/12.
//

import UIKit
import WWPrint
import WWScreenRecorder

// MARK: - ViewController
final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startRecoding(_ sender: UIBarButtonItem) {
        
        WWScreenRecorder.shared.stop { _ in
            
            WWScreenRecorder.shared.start { result in
                switch result {
                case .failure(let error): wwPrint("startRecording => \(error)")
                case .success(let isSuccess): wwPrint("startRecording => \(isSuccess)")
                }
            }
        }
    }
    
    @IBAction func stopRecoding(_ sender: UIBarButtonItem) {
        
        WWScreenRecorder.shared.stop { result in
            switch result {
            case .failure(let error): wwPrint("startRecording => \(error)")
            case .success(let previewViewController): self.present(previewViewController, animated: true)
            }
        }
    }
}

