//
//  UIRepresentableBootcamp.swift
//  BootCamp
//
//  Created by MM on 20.12.2022.
//

import SwiftUI

struct UIRepresentableBootcamp: View {
    
    @State var text = ""
    var body: some View {
        ZStack {
            BasicUIViewRepresentable()
                .opacity(0.7)
            VStack {
                TextField("Type here...", text: $text)
                    .padding()
                UITextFieldRepresentable(text: $text)
                    .updatePlaceholder(placeholder: "Brand new placeholder...")
                    .frame(height: 55)
                    .background(.gray)
                    .padding()
                    .cornerRadius(10)
                    
                
            }
            
        }
    }
}

struct UITextFieldRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    init(text: Binding<String>, placeholder: String = "Default placeholder...") {
        self._text = text
        self.placeholder = placeholder
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        var placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor : UIColor.white
            ])
        textField.attributedPlaceholder = placeholder
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func updatePlaceholder(placeholder: String) -> UITextFieldRepresentable {
        var viewRepresent = self
        viewRepresent.placeholder = placeholder
        return viewRepresent
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}



struct UIRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        UIRepresentableBootcamp()
    }
}

