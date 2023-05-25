//
//  StepMotion.swift
//  beSafik
//
//  Created by Safik Widiantoro on 25/05/23.
//

import SwiftUI
import CoreMotion


struct StepMotion : View {
    @State private var totalSteps1: Int = 0
    @State private var activityType: String = ""
    private let pedometer = CMPedometer()
    private let activityManager = CMMotionActivityManager()

    var body: some View {
        VStack {
            
            Text("Total Steps: \(totalSteps1)")
            if totalSteps1 >= 10 && totalSteps1 <= 100 {
                Text("Kaya nyampe aja sampe 1000")
            } else if totalSteps1 >= 101 && totalSteps1 <= 300{
                Text("niat banget bang nyerah aja bisa kali")
            }else if totalSteps1 >= 301 && totalSteps1 <= 800{
                Text("lebih kenceng keponakan lagi latian jalan")
            }
            else if totalSteps1 >= 1000 {
                Text("prank sorry gaada apa2")
            }
            
            if activityType == "Running" {
                Text("effort juga lari buset")
            } else if activityType == "Walking" {
                Text("semangat bangg")
            }
            else if activityType == "Automotive" {
                Text("Buset! mikir dong disuruh jalan malah pake angkutan sapi")
            }else {
                Text("Kaga gerak apa?")
            }
            Text("hint: You need to take 1000 steps \nif you want to know me")
                .padding(.top,80)
            
        }
        .onAppear {
            startStepUpdates()
            startActivityUpdates()
        }
    }

    func startStepUpdates() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { data, error in
                if let stepData = data {
                    DispatchQueue.main.async {
                        totalSteps1 = Int(truncating: stepData.numberOfSteps)
                    }
                }
            }
        }
    }

    func startActivityUpdates() {
        if CMMotionActivityManager.isActivityAvailable() {
            activityManager.startActivityUpdates(to: OperationQueue.main) { data in
                if let activity = data {
                    DispatchQueue.main.async {
                        if activity.running {
                            activityType = "Running"
                        } else if activity.walking {
                            activityType = "Walking"
                        } else if activity.automotive {
                            activityType = "Automotive"
                        }
                    }
                }
            }
        }
    }
}
