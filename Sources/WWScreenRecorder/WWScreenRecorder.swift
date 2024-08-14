//
//  WWScreenRecorder.swift
//  WWScreenRecorder
//
//  Created by William.Weng on 2024/8/12.
//

import ReplayKit

// MARK: - WWScreenRecorder
open class WWScreenRecorder: NSObject {
    
    public static let shared = WWScreenRecorder()
    
    /// 是否正在錄影
    public var isRecording: Bool { self.screenRecorder.isRecording }
    
    private let screenRecorder = RPScreenRecorder.shared()
    
    private override init() { super.init() }
    
    /// 自定義錯誤
    public enum CustomError: Error {
        case isNotAvailable                 // 不支援螢幕錄製
        case isPreviewViewControllerNull    // 沒有RPPreviewViewController
    }
}

// MARK: - RPScreenRecorderDelegate, RPPreviewViewControllerDelegate
extension WWScreenRecorder: RPScreenRecorderDelegate, RPPreviewViewControllerDelegate {
    
    public func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        previewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - 公開函式
public extension WWScreenRecorder {
    
    /// [開始錄製螢幕畫面](https://www.appcoda.com.tw/replaykit/)
    /// - Parameters:
    ///   - isCameraEnabled: [錄製鏡頭的畫面](https://developer.apple.com/documentation/replaykit)
    ///   - isMicrophoneEnabled: [錄製麥克風取得的聲音](https://developer.apple.com/cn/videos/play/wwdc2021/10101/)
    ///   - result: [(Result<Bool, Error>) -> Void](https://support.apple.com/zh-tw/guide/security/seca5fc039dd/web)
    func startRecording(isCameraEnabled: Bool = true, isMicrophoneEnabled: Bool = true, result: @escaping (Result<Bool, Error>) -> Void) {
        
        guard screenRecorder.isAvailable else { result(.failure(CustomError.isNotAvailable)); return }
        
        screenRecorder.isCameraEnabled = isCameraEnabled
        screenRecorder.isMicrophoneEnabled = isMicrophoneEnabled

        screenRecorder.startRecording { error in
            if let error = error { result(.failure(error)); return }
            result(.success(true))
        }
    }
    
    /// [停止錄製螢幕畫面](https://medium.com/@jerryleetw1992/錄製app畫面-replaykit-by-swiftui-54927c6347b7)
    /// - Parameter result: [Result<RPPreviewViewController, Error>) -> Void](https://youtu.be/9dFsoQKBT0g)
    func stopRecording(result: @escaping (Result<RPPreviewViewController, Error>) -> Void) {
        
        screenRecorder.stopRecording { previewViewController, error in
            
            if let error = error { result(.failure(error)); return }
            
            if let previewViewController = previewViewController {
                previewViewController.previewControllerDelegate = self
                result(.success(previewViewController)); return
            }
            
            result(.failure(CustomError.isPreviewViewControllerNull))
        }
    }
}
