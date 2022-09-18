//
//  SubscriberBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/26/21.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    // var timer: AnyCancellable? --> use set of cancellables instead(1)
    var cancellables = Set<AnyCancellable>()
    
    @Published var textTextField: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        updateCount()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func updateCount() {
//        timer =            use .store instead for set of cancellables(1)
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                // this line checks if weak self <> from nil, so doesn't need self? anymore
                guard let self = self else { return }
//                self.count < 10 ? self.count += 1 : self.timer?.cancel()    (1)
                self.count += 1
                // mostra como cancelar
//                if self.count == 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
                
                    
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textTextField
            // check TextField only 0.5 seconds after stop typing
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            // cannot use weak self on .assign, better use .sink
//          .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
                // self?.showButton = isValid   ---> works fine
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count > 20 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    let oneColor: UIColor =  #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(vm.count)")
                .font(.largeTitle)
            TextField("Add your text here...", text: $vm.textTextField)
                .padding()
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)).cornerRadius(10))
                .padding(.horizontal)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textTextField.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(
                                vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.title)
                        .padding(.trailing)
                        .padding(.horizontal),
                    alignment: .trailing)
            Button {
                //
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.cornerRadius(10))
                    .padding(.horizontal)
                    .opacity(
                        vm.showButton ? 1.0 : 0.5
                    )
            }
            .disabled(!vm.showButton)
        }
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
