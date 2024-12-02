//
//  SortPicker.swift
//  Finder
//
//  Created by dgsw07 on 10/30/24.
//

import SwiftUI

struct SortPickerMenu: View {
    @State var sortPickerOn = false
    var body: some View {
        Button {
            sortPickerOn.toggle()
        } label: {
            HStack {
                Text("정렬 방법")
                Image(systemName: "chevron.down")
            }
            .foregroundColor(.black)
            .overlay {
                if sortPickerOn {
                    VStack {
                        Text("dd")
                        Text("dd")
                        Text("dd")
                        Text("dd")
                        Text("dd")
                    }
                }
            }
        }
        
    }
}

#Preview {
    SortPickerMenu()
}
