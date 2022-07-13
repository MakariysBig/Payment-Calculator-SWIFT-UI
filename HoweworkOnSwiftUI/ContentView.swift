import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: Double?
    @State private var numberOfPeople: Int?
    @State private var tipPercentage = 5
    @State private var paymentAmount = 0.0
    
    private let tipPercentages = [5, 10, 15, 20, 25, 30, 0]
    
    init(checkAmount: Double?) {
        self.checkAmount = checkAmount
    }
    
    init(numberOfPeople: Int?) {
        self.numberOfPeople = numberOfPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Check amount:")
                    TextField("Enter check amount", value: $checkAmount, format:.currency(code: Locale.current.currencyCode ?? "USD"), prompt: nil)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    Text("Number of people:")
                    TextField("Enter number of people", value: $numberOfPeople, format: .number)
                        .keyboardType(.numberPad)
                }
                
                Picker("Choose tip amount", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) { percentage in
                        Text(percentage, format: .percent)
                    }
                }
                
                Section {
                    Button("Tap for calcualte: \(paymentAmount) $") {
                        calculatePaymentAmount()
                    }
                    Button("Clean") {
                        checkAmount = nil
                        numberOfPeople = nil
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Payment calculator")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func calculatePaymentAmount() {
        guard let checkAmount = checkAmount else {
            return
        }
        
        let tipPercentage = Double(tipPercentage)
        let numberOfPeople = Double(numberOfPeople ?? 0)
        
        let calculatePaymentAmount = ((checkAmount + (checkAmount * tipPercentage / 100)) / numberOfPeople)
        paymentAmount = calculatePaymentAmount
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(checkAmount: nil)
        }
    }
}
