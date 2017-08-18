//
//  PerformanceInspector.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/26/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

#if os(iOS)

public struct PerformanceInspectorFlags : OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let None                      = PerformanceInspectorFlags(rawValue: 0)

    public static let Window                    = PerformanceInspectorFlags(rawValue: 1 << 1)
    public static let FPS                       = PerformanceInspectorFlags(rawValue: 1 << 2)
    public static let Stalling                  = PerformanceInspectorFlags(rawValue: 1 << 3)
    public static let StallingException         = PerformanceInspectorFlags(rawValue: 1 << 4)

    public static let All                       = PerformanceInspectorFlags(rawValue: 1 << 5 - 1)
}

open class PerformanceInspector: NSObject {
    static var flags: PerformanceInspectorFlags = PerformanceInspectorFlags.All

    open static func start() {
        if flags.contains(.FPS) {
            start_FPS()
        }
        if flags.contains(.Window) {
            start_Window()
        }
    }

    open static func stop() {
        stop_FPS()
        stop_Window()
    }
}

// MARK: - FPS

extension PerformanceInspector {
    @nonobjc private static var started_fps: Bool = false

    @nonobjc private static var displayLink: CADisplayLink? = nil
    @nonobjc private static var timerSource: DispatchSourceTimer? = nil

    @nonobjc private static var frames: Int = 0
    @nonobjc private static var interval: Double = 0.25
    @nonobjc private static var counter: Int = 0

    @nonobjc private static var lastTime: CFTimeInterval = 0

    fileprivate static func start_FPS() {
        if started_fps {
            return
        }

        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkCallback))
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)

        timerSource = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0),
                                                     queue: DispatchQueue.global())

        timerSource!.scheduleRepeating(deadline: .now(),
                                       interval: .milliseconds(Int(interval * 1000)),
                                       leeway: .microseconds(0))

        timerSource!.setEventHandler {
            let elapsedTime = CFAbsoluteTimeGetCurrent() - lastTime
            counter = Int(round(Double(frames) / elapsedTime))
            lastTime = CFAbsoluteTimeGetCurrent()
            frames = 0
            OperationQueue.main.addOperation({
                inspectorViewController?.setFPSCounter(counter)
            })
        }
        lastTime = CFAbsoluteTimeGetCurrent()
        timerSource!.resume()
        
        started_fps = true
    }

    static func displayLinkCallback(_ sender: CADisplayLink) {
        frames += 1
    }

    fileprivate static func stop_FPS() {
        if !started_fps {
            return
        }

        timerSource!.cancel()
        timerSource = nil

        displayLink?.invalidate()
        displayLink = nil

        started_fps = false
    }
}

// MARK: - Window

extension PerformanceInspector {
    @nonobjc private static var started_window: Bool = false

    @nonobjc static var inspectorWindow: UIWindow? = nil
    @nonobjc static weak var inspectorViewController: PerformanceInspectorViewController? = nil

    fileprivate static func start_Window() {
        if started_window {
            return
        }
        let size = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: CGPoint.zero, size: size)
        inspectorWindow = UIWindow(frame: frame)
        inspectorWindow?.rootViewController = PerformanceInspectorViewController()
        inspectorWindow?.windowLevel = UIWindowLevelAlert + 1
        inspectorWindow?.isHidden = false
        inspectorViewController = inspectorWindow?.rootViewController as? PerformanceInspectorViewController

        NotificationCenter.default.addObserver(self, selector: #selector(deviceRotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    @objc private static func deviceRotated() {
        let size = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: CGPoint.zero, size: size)
        inspectorWindow?.frame = frame
    }

    fileprivate static func stop_Window() {
        if !started_window {
            return
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        inspectorViewController = nil
        inspectorWindow?.isHidden = true
        inspectorWindow = nil
    }
}

#endif
