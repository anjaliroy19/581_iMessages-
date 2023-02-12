//
//  ColorCodes.swift //formerly ContentView.swift
//  COLOR PALLETE IN SWIFT
//
//  Created by Morgan Marino on 12/02/22; edited by Morgan Marino on 02/11/2023
//

import SwiftUI

struct ContentView: View {
    let m_font = Font
        .system(size: 24)
        .monospaced()
    let m_white = Color(red: 246/255, green: 246/255, blue: 246/255)
    let m_black = Color(red: 30/255, green: 30/255, blue: 31/255)
    let m_lightgray = Color(red: 202/255, green: 204/255, blue: 210/255)
    let m_rose = Color(red: 234/255, green: 66/255, blue: 143/255)
    let m_red = Color(red: 233/255, green: 64/255, blue: 47/255)
    let m_yellow = Color(red: 223/255, green: 253/255, blue: 82/255)
    let m_lizardgreen = Color(red: 174/255, green: 250/255, blue: 78/255)
    let m_springgreen = Color(red: 116/255, green: 251/255, blue: 175/255)
    let m_blue = Color(red: 102/255, green: 221/255, blue: 239/255)
    @State private var code: String = ""
    @State private var language: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("//iMessage++\n-Group 15")
                .font(m_font)
                .foregroundColor(m_lightgray)
            Text("Test - White")
                .font(m_font)
                .foregroundColor(m_white)
            Text("Test - Black")
                .font(m_font)
                .foregroundColor(m_black)
            Text("Test - Rose")
                .font(m_font)
                .foregroundColor(m_rose)
            Text("Test - Red")
                .font(m_font)
                .foregroundColor(m_red)
            Text("Test - Yellow")
                .font(m_font)
                .foregroundColor(m_yellow)
            Text("Test - Lizard Green")
                .font(m_font)
                .foregroundColor(m_lizardgreen)
            Text("Test - Spring Green")
                .font(m_font)
                .foregroundColor(m_springgreen)
            Text("Test - Blue")
                .font(m_font)
                .foregroundColor(m_blue)
            TextField("Code Here: ",text: $code)
                .font(m_font)
                .foregroundColor(m_black)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
