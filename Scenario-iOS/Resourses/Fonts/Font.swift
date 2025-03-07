//
//  Font.swift
//  Senario
//
//  Created by dgsw07 on 3/5/25.
//

import SwiftUI

extension Font {
    enum PretendardWeight {
           case black
           case bold
           case extrabold
           case extralight
           case light
           case medium
           case regular
           case semibold
           case thin
           
           var value: String {
               switch self {
               case .black:
                   return "Black"
               case .bold:
                   return "Bold"
               case .extrabold:
                   return "ExtraBold"
               case .extralight:
                   return "ExtraLight"
               case .light:
                   return "Light"
               case .medium:
                   return "Medium"
               case .regular:
                   return "Regular"
               case .semibold:
                   return "SemiBold"
               case .thin:
                   return "Thin"
               }
           }
       }

       static func pretendard(_ weight: PretendardWeight, size fontSize: CGFloat) -> Font {
           let familyName = "Pretendard"
           let weightString = weight.value

           return Font.custom("\(familyName)-\(weightString)", size: fontSize)
       }
   }

