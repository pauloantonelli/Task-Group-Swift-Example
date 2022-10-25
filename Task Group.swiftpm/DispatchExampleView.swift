//
//  File.swift
//  Task Group
//
//  Created by Paulo Antonelli on 25/10/22.
//

import SwiftUI

struct DispatchExampleView: View {
    let timeIntervalList: Array<TimeInterval> = [1, 3, 5, 7, 9]
    @State private var backgroundColor: Color = Color.red
    @State private var label: String = ""
    @State private var calclabel: String = ""
    let backScreen: () -> Void
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .ignoresSafeArea()
                .foregroundColor(self.backgroundColor)
            VStack {
                Button("Calcular na thread background") {
                    self.calculate()
                }.foregroundColor(Color.white)
                Text(self.label).foregroundColor(Color.white)
                Text(self.calclabel).foregroundColor(Color.white)
            }
        }
        .navigationTitle("Dispatch Example")
        .navigationBarItems(leading: Button("Voltar") {
            backScreen()
        })
        .foregroundColor(Color.white)
    }
}

extension DispatchExampleView {
    func calculate() -> Void {
        self.label = "Calculando"
        let group = DispatchGroup()
        for time in self.timeIntervalList {
            group.enter()
            print("Entrando no grupo numero \(time)")
            self.calclabel = "Entrando no grupo numero \(time)"
            DispatchQueue.global().asyncAfter(deadline: .now() + time) {
                group.leave()
                print("Saindo do grupo numero \(time)")
                self.calclabel = "Saindo do grupo numero \(time)"
            }
        }
        group.notify(queue: .main) {
            print("Todas as operações finalizadas")
            self.calclabel = "Todas as operações finalizadas"
            self.label = "Finalizado"
            self.backgroundColor = Color.blue
        }
    }
}
