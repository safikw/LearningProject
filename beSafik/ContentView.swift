//
//  ContentView.swift
//  beSafik
//
//  Created by Safik Widiantoro on 25/05/23.
//

import SwiftUI
import RealityKit
import ARKit
import HealthKit

struct ContentView : View {
    @State var isSafik = false
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthStore = HealthStore()
    }
    
    private func updateUIFromStatistic(_ statisticsCollection: HKStatisticsCollection){
        let startDate = Calendar.current.date(byAdding: .day, value: -7 ,to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) {(statistics, stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    private var totalStep: Int {
        steps.reduce(0) { $0 + $1.count }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Button("Click and point the camera towards your face.", action: {
                    isSafik.toggle()
                })
                ARViewContainer(isSafik: $isSafik).frame(width: 300, height: 500)
                Text("Total Steps: in a week \(totalStep)")
                    .font(.headline)
                    .padding()
                    .onAppear() {
                        if let healthStore = healthStore {
                            healthStore.requestAuthorization{
                                success in
                                if success {
                                    healthStore.calculateSteps{
                                        statisticCollection in
                                        if let statisticCollection = statisticCollection {
                                            //update UI here
                                            
                                            updateUIFromStatistic(statisticCollection)
                                        }
                                    }
                                }
                            }
                        }
                    }
                if totalStep <= 3000 {
                    Text("WKWKWK my niece is better at walking")
                } else {
                    Text("SOSO😒")
                }
                
                
                NavigationLink(destination: StepMotion()) {
                    Text("I have a challenge for you to know my personality.")
                }
                //end of navigation link
                
            }
            
            
            
        }
        
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var isSafik: Bool
    
    func makeUIView(context: Context) -> ARView {
        
        
        let arView = ARView(frame: .zero)
        let configuration = ARFaceTrackingConfiguration()
        arView.session.run(configuration)
        
        updateARView(arView) // Initial setup
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        updateARView(uiView)
        
    }
    
    private func updateARView(_ arView: ARView) {
        if isSafik {
            let boxAnchor = try! SafikExperience.loadBox()
            arView.scene.anchors.removeAll()
            arView.scene.anchors.append(boxAnchor)
        } else {
            arView.scene.anchors.removeAll()
        }
    }
}

//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//#endif
