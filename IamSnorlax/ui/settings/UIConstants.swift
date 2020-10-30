//
//  UIConstants.swift
//  Dogoplay
//
//  Created by Diego Otero Mata on 18/05/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import Foundation
import SkeletonView
import Atributika

private enum FontType: String {
    case bold = "-Bold"
    case semibold = "-SemiBold"
    case italic = "-Italic"
    case regular = "-Regular"
}

class UIConstants {
    static let shared = UIConstants()

    // MARK: - Skeletons settings

    let skeletonAnimation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
    let skeletonGradient = SkeletonGradient(baseColor: .skeletonDefault)
    let skeletonTransition = SkeletonTransitionStyle.crossDissolve(0.25)

    // MARK: - Insets settings

    var sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)

    // MARK: - Collections settings

    var storiesCollumns = 1
    
    // MARK: - HTML text rendering settings

    fileprivate var defaultParagraph: NSMutableParagraphStyle {
        get {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .left
            paragraph.paragraphSpacing = 8
            return paragraph
        }
    }
    fileprivate var centerParagraph: NSMutableParagraphStyle {
        get {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            return paragraph
        }
    }
    fileprivate var listParagraph: NSMutableParagraphStyle {
        get {
            let paragraph = NSMutableParagraphStyle()
            let identation: CGFloat = 14
            paragraph.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
            paragraph.defaultTabInterval = 15
            paragraph.firstLineHeadIndent = identation
            paragraph.headIndent = identation + 13
            paragraph.paragraphSpacing = 10
            return paragraph
        }
    }
    
    private init() {}
    
    private func font(named: String, style: FontType, size: CGFloat) -> UIFont {
        var defaultFont: UIFont
        switch style {
        case .bold:
            defaultFont = .boldSystemFont(ofSize: size)
        case .semibold:
            defaultFont = .boldSystemFont(ofSize: size)
        case .italic:
            defaultFont = .italicSystemFont(ofSize: size)
        case .regular:
            defaultFont = .systemFont(ofSize: size)
        }
        return UIFont(name: "\(named)\(style.rawValue)", size: size) ?? defaultFont
    }
    
    func allStyles(size: CGFloat) -> Style {
        let fontName = "Montserrat"
        return Style.font(font(named: fontName, style: .regular, size: size))
            .foregroundColor(UIColor(named: "descriptions") ?? UIColor.lightGray)
            .paragraphStyle(defaultParagraph)
    }
    
    func htmlStyles(size: CGFloat) -> [Style] {
        let fontName = "Montserrat"
        let htmlStyles = [
            Style("b").font(font(named: fontName, style: .bold, size: size)),
            Style("strong").font(font(named: fontName, style: .semibold, size: size)),
            Style("i").font(font(named: fontName, style: .italic, size: size)),
            Style("em").font(font(named: fontName, style: .italic, size: size)),
            Style("mark").font(font(named: fontName, style: .regular, size: size)).backgroundColor(.yellow),
            Style("small").font(font(named: fontName, style: .regular, size: size - 2)),
            Style("del").font(font(named: fontName, style: .regular, size: size)),
            Style("ins").font(font(named: fontName, style: .regular, size: size)).underlineStyle(.single),
            Style("sub").font(font(named: fontName, style: .regular, size: size - 2)).baselineOffset(-2),
            Style("sup").font(font(named: fontName, style: .regular, size: size - 2)).baselineOffset(2),
            Style("center").font(font(named: fontName, style: .regular, size: size)).paragraphStyle(centerParagraph),
            Style("ul").font(font(named: fontName, style: .regular, size: size)).paragraphStyle(listParagraph)
        ]
        return htmlStyles
    }
}
