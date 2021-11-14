//
//  ParameterView.swift
//  Pokemon
//
//  Created by Vladimir Stepanchikov on 12.11.2021.
//

import SwiftUI

struct ParameterView: View {
    let name: String
    let color: Color
    let value: Int

    var body: some View {
        HStack {
            Text(name)
                .font(.system(.body, design: .monospaced))
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .frame(width: 150, height: 20)
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(color)
                    .frame(width: value <= 100
                           ? 150 * CGFloat(value) / 100
                           : 150,
                           height: 20)
            }
            VStack(alignment: .trailing) {
                Text("\(value)")
                    .font(.system(.body, design: .monospaced))
                    .frame(width: 60)
            }
        }
    }
}

struct PokemonStatView_Previews: PreviewProvider {
    static var previews: some View {
        ParameterView(name: "Atk", color: .red, value: 8888)
    }
}
