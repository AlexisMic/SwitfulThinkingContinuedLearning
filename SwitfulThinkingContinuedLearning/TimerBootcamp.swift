//
//  TimerBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/26/21.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // Timer example
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    // Countdown example
    /*
    @State private var count = 10
    @State private var finalText: String? = nil
    */
     
    // Countdown to date
    /*
    @State private var timeRemaining: String = ""
    var futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
     */
    
    // Animation
    /*
    @State private var count: Int = 0
     */
    
    // TabView
    @State private var count: Int = 1
     
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.blue, .black]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()
            // Timer and Countdown examples
            /*
            Text(timeRemaining)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
             */
            // Animation
            /*
            HStack(spacing: 15) {
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
            }
            .foregroundColor(.white)
            .frame(width: 150)
             */
            // TabView
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(Color.blue)
                    .tag(1)
                Rectangle()
                    .foregroundColor(Color.red)
                    .tag(2)
                Rectangle()
                    .foregroundColor(Color.orange)
                    .tag(3)
                Rectangle()
                    .foregroundColor(Color.black)
                    .tag(4)
                Rectangle()
                    .foregroundColor(Color.pink)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
        }
        .onReceive(timer, perform: { _ in   // pode usar _ ou value
            
            // TabView
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
            
            // Animation
            /*
            withAnimation(.easeOut(duration: 0.5)) {
                count = count == 3 ? 0 : count + 1
            }
            */
            
            // Countdown to date
            //updateTimeRemaining()
            
            // Countdown example
            /*
            if count <= 1 {
                finalText = "Wow!"
            } else {
                count -= 1
            }
             */
            
            // Timer example
            //currentDate = value
            
        })
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerBootcamp()
        }
    }
}
