//
//  LongPressGestureBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/18/21.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State private var hasTaped: Bool = false
    var body: some View {
        Text(hasTaped ? "COMPLETED" : "NOT COMPLETED")
            .padding()
            .padding(.horizontal)
            .background(hasTaped ? Color.green : Color.gray)
            .cornerRadius(10)
            .onTapGesture {
                hasTaped.toggle()
            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
