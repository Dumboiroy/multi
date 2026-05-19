import AVFoundation

class DeviceManager {
    static let shared = DeviceManager()

    func checkCameraAccess() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    func checkMicrophoneAccess() -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .audio) == .authorized
    }

    func requestCameraAccess(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        @unknown default:
            completion(false)
        }
    }

    func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)

        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                completion(granted)
            }
        @unknown default:
            completion(false)
        }
    }
}
