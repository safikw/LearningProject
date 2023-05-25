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
    var body: some View {
        VStack{
            Button("Safik", action: {
                isSafik.toggle()
            })
            ARViewContainer(isSafik: $isSafik).frame(width: 300, height: 300)
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

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
