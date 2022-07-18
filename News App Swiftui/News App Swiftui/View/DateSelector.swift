//
//  DateSelector.swift
//  News App Swiftui
//
//  Created by Isaac Paschall on 6/9/22.
//

import SwiftUI

struct DateSelector: View {

    @Environment(\.presentationMode) var presentationMode
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var didChangeDate: Bool
    @State private var isPickingStartDate = true
    private let oneMonthPrior = (Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date())

    var body: some View {
        NavigationView {
            VStack {
                dateSelectionTitle
                Spacer()
                dateSelectionCalendar
                nextAndDoneButton
                .padding(.bottom, LayoutGuide.padding)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    cancelButton
                }
            }
        }
    }

    private var dateSelectionTitle: some View {
        Text("Select " + (isPickingStartDate ? "Start" : "End") + " Date")
            .font(.largeTitle)
            .foregroundColor(Theme.accentColor)
            .padding(.top, LayoutGuide.padding)
    }

    @ViewBuilder
    private var dateSelectionCalendar: some View {
        if isPickingStartDate {
            DatePicker("Choose Start Date", selection: $startDate, in: oneMonthPrior...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(Theme.accentColor)
        } else {
            DatePicker("Choose End Date", selection: $endDate, in: startDate...Date(), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(Theme.accentColor)
        }
    }

    private var nextAndDoneButton: some View {
        Button {
            if isPickingStartDate {
                withAnimation {
                    isPickingStartDate = false
                }
            } else {
                didChangeDate = true
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Text(isPickingStartDate ? "Next" : "Done")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(
                    Capsule()
                        .fill(Theme.accentColor)
                )
        }
    }

    private var cancelButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
}
