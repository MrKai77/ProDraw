//
//  DrawView.swift
//  Prodraw
//
//  Created by Kai Azim on 2021-10-01.
//

import SwiftUI
import PencilKit
import AlertToast

struct DrawView: View {
    
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color : Color = .black
    @State var type : PKInkingTool.InkType = .pencil
    @State var isSaved = false
    
    var body: some View {
        ZStack {
            DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $color)
            
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(isDraw ? Color(.systemGray) : Color(.systemGray3))
                    .frame(height: 60)
                    .shadow(color: Color(.systemGray), radius: 10)
                    .overlay(
                        HStack {
                            Spacer()
                            Group {             // ERASER
                                Button(action: {
                                    isDraw = false
                                }, label: {
                                    Image(systemName: "pencil.slash")
                                        .foregroundColor(.black)
                                })
                                Spacer()
                            }
                            Group {             // BRUSH SELECT
                                Menu {
                                    Button(action: {    // HIGHLIGHTER SELECTION
                                        isDraw = true
                                        type = .marker
                                    }, label: {
                                        Label {
                                            Text("Marker")
                                        } icon: {
                                            Image(systemName: "highlighter")
                                        }
                                    })
                                    Button(action: {    // PENCIL SELECTION
                                        isDraw = true
                                        type = .pencil
                                    }, label: {
                                        Label {
                                            Text("Pencil")
                                        } icon: {
                                            Image(systemName: "applepencil")
                                        }
                                    })

                                    Button(action: {    // PEN SELECTION
                                        isDraw = true
                                        type = .pen
                                    }, label: {
                                        Label {
                                            Text("Pen")
                                        } icon: {
                                            Image(systemName: "pencil.tip")
                                        }
                                    })
                                } label: {  // MENU LABEL
                                    Image(systemName: "scribble")
                                        .foregroundColor(.black)
                                }
                                Spacer()
                            }
                            Group {             // COLORPICKER
                                ColorPicker("", selection: $color)
                                    .labelsHidden()
                                Spacer()
                            }
                            Group {             // EXPORT BUTTON
                                Button(action: {
                                    saveImage()
                                    isSaved.toggle()
                                }, label: {
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundColor(.black)
                                })

                                Spacer()
                            }
                            Group {         // DELETE
                                Button(action: {
                                    canvas.drawing = PKDrawing()
                                }, label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.black)
                                })
                                Spacer()
                            }
                            
                        }
                    )
                    .padding(25)
                    .animation(.easeOut)
            }
        }
        .ignoresSafeArea()
        .toast(isPresenting: $isSaved) {
            AlertToast(displayMode: .hud,
                       type: .systemImage("hand.draw.fill", .black),
                       title: "Drawing Saved!")
        }
    }
    func saveImage() {  // FUNCTION TO SAVE IMAGE
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
