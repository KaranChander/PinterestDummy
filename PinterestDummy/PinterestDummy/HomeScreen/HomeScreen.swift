//
//  ContentView.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/10/24.
//

import SwiftUI
import SwiftData
import Kingfisher

struct ColumnModel {
    var id = UUID()
    var item: GridItem
    
    static let columns = [
        ColumnModel(item:  GridItem()),
        ColumnModel(item:  GridItem())

    ]
}
struct HomeScreen: View {

    @StateObject private var pinsViewModel = PinsHomeViewModel()
    private let flexibleColumn = [
         
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
     ]
    var body: some View {
        NavigationSplitView {
            ScrollView {
                if !pinsViewModel.pins.isEmpty {
                    
                    HStack(alignment: .top, spacing: 0) {
                        

                                
                        VStack {
                            ForEach(Array(pinsViewModel.pins.enumerated()), id: \.offset) { index, pin in
                                if index%2 == 0 {
                                    NavigationLink(destination: pinCardView(pin: pin)) {
                                        pinCardView(pin: pin)
                                            .navigationTitle("Your Pins")
                                    }
                                }
                            }
                        }
                        
                        VStack {
                            ForEach(Array(pinsViewModel.pins.enumerated()), id: \.offset) { index, pin in
                                if index%2 != 0 {
                                    NavigationLink(destination: pinCardView(pin: pin)) {
                                        pinCardView(pin: pin)
                                            .navigationTitle("Your Pins")
                                    }
                                }
                            }
                        }
                        }
                        lastRowView
                } else {
                    // loader view
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func pinsForColumn(_ columnId: UUID) -> [Pin] {
            let columnIndex = ColumnModel.columns.firstIndex { $0.id == columnId } ?? 0
            return pinsViewModel.pins.enumerated().compactMap { index, pin in
                return index % ColumnModel.columns.count == columnIndex ? pin : nil
            }
        }
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch pinsViewModel.paginationState {
            case .loading:
                loaderView()
            case .idle:
                EmptyView()
            default:
                Text("Error")
            }
        }
        .frame(height: 50)
        .onAppear {
            pinsViewModel.fetchPins()
        }
    }
    
    @ViewBuilder
    func loaderView() -> some View {
        ProgressView()
            .frame(width: 200, height: 200)
            .foregroundStyle(.black)
    }

    @ViewBuilder
    func pinCardView(pin: Pin) -> some View {
        VStack(spacing: 8) {
                KFImage(URL(string: pin.image)!)
                    .resizable()
                    .onSuccess({ imageResult in
                        print(imageResult.image.size.width, imageResult.image.size.height, imageResult.originalSource)
                    })
                    .cornerRadius(15)
                    .aspectRatio(contentMode: .fit)
                Text(pin.description)
                .font(.caption2)
                .foregroundStyle(.black)
                .fontWeight(.light)
        }.padding()
    }


    
}

#Preview {
    HomeScreen()
//        .modelContainer(for: Item.self, inMemory: true)
}
