//
//  DrawingView.swift
//  Prodraw
//
//  Created by Kai Azim on 2021-10-01.
//

import SwiftUI
import PencilKit

struct DrawingView : UIViewRepresentable {  // DRAWING INFO
    
    @Binding var canvas : PKCanvasView          // canvas to draw on
    @Binding var isDraw : Bool                  // Am I drawing or erasing?
    @Binding var type : PKInkingTool.InkType    // Pencil, Pen or Marker?
    @Binding var color : Color                  // Tip color
    
    var ink : PKInkingTool {
        PKInkingTool(type, color: UIColor(color))   // Set up the tip
    }
    
    let eraser = PKEraserTool(.bitmap)  // Eraser type
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.backgroundColor = .clear // Background color
        canvas.isOpaque = false         // Set is to be not opaque
        
        canvas.drawingPolicy = .anyInput    // Any input can draw
        canvas.tool = isDraw ? ink : eraser // Determine if the tool draws or erases
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDraw ? ink : eraser
    }
}
