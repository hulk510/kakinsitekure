//
//  ContentView.swift
//  kakinsitekure
//
//  Created by 後藤遥 on 2023/05/04.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    @State var isBlinking = false
    @State var isSlide = false
    @State var products: [Product] = []
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            // 文字を点滅させる
            Text("お金が必要です!!!")
                .foregroundColor(.red)
                .opacity(isBlinking ? 0.5 : 1.0)
                .scaleEffect(isBlinking ? 1.3 : 1.0)
                .rotationEffect(.degrees(-10))
                .bold()
                .font(.title)
                .onAppear {
                    withAnimation(.linear(duration: 0.5).repeatForever()) {
                        self.isBlinking.toggle()
                    }
                }
                HStack {
                    Image(systemName: "arrowshape.right.fill")
                        .foregroundColor(.red.opacity(0.6))
                    Button(action: {}) {
                        Text("現金を送る")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 160, height: 50)
                            .background(.green)
                            .cornerRadius(30)
                    }
                    Image(systemName: "arrowshape.left.fill")
                        .foregroundColor(.red.opacity(0.6))

                }
                .padding()
            Text("レターパックで現金を送れないは詐欺です")
                .foregroundColor(.red)
                .font(.headline)
                .padding(.top)
            Text("レターパックで現金は送れます!!!")
                .foregroundColor(.green)
                .bold()
                .font(.subheadline)
                .offset(x: isSlide ? 50 : -50)
                .onAppear {
                    withAnimation(.linear(duration: 1.2).repeatForever()) {
                        self.isSlide.toggle()
                    }
                }
//            List(products) {
//                p in
//                Button(action: {}) {
//                    Text("\(p.displayPrice) - \(p.displayName)")
//                }
//            }
            Spacer()
        }
        .frame(height: 500)
        .task {
            do {
                try await loadProducts()
            } catch {
                print(error)
            }
        }
        .padding()
    }
    func loadProducts() async throws {
        // リモートソースから取得できるといいらしい
        let productIdList = [
            "com.MMMM.kakinshitekure.cupofcoffee"
        ]

        products = try await Product.products(for: productIdList)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
