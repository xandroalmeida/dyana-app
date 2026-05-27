import AppKit

struct Color {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat

    init(_ hex: String, alpha: CGFloat = 1) {
        let value = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: value)
        var number: UInt64 = 0
        scanner.scanHexInt64(&number)

        red = CGFloat((number >> 16) & 0xff) / 255
        green = CGFloat((number >> 8) & 0xff) / 255
        blue = CGFloat(number & 0xff) / 255
        self.alpha = alpha
    }

    var nsColor: NSColor {
        NSColor(calibratedRed: red, green: green, blue: blue, alpha: alpha)
    }
}

let primary = Color("#1D1D1F").nsColor
let secondary = Color("#6E6E73").nsColor
let tertiary = Color("#0071E3").nsColor
let neutral = Color("#F5F5F7").nsColor
let surface = Color("#FFFFFF").nsColor
let stroke = Color("#D2D2D7").nsColor

func writePNG(_ bitmap: NSBitmapImageRep, to path: String) {
    guard let data = bitmap.representation(using: .png, properties: [:]) else {
        fatalError("Could not render \(path)")
    }

    try! FileManager.default.createDirectory(
        atPath: (path as NSString).deletingLastPathComponent,
        withIntermediateDirectories: true
    )
    try! data.write(to: URL(fileURLWithPath: path))
}

func image(width: Int, height: Int, draw: (CGRect) -> Void) -> NSBitmapImageRep {
    let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: width,
        pixelsHigh: height,
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    )!
    bitmap.size = NSSize(width: width, height: height)

    let context = NSGraphicsContext(bitmapImageRep: bitmap)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    context.imageInterpolation = .high
    draw(CGRect(origin: .zero, size: CGSize(width: width, height: height)))
    NSGraphicsContext.restoreGraphicsState()
    return bitmap
}

func roundedRect(_ rect: CGRect, radius: CGFloat, color: NSColor) {
    color.setFill()
    NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius).fill()
}

func ellipse(_ rect: CGRect, fill: NSColor? = nil, stroke strokeColor: NSColor? = nil, lineWidth: CGFloat = 1) {
    let path = NSBezierPath(ovalIn: rect)
    if let fill {
        fill.setFill()
        path.fill()
    }
    if let strokeColor {
        strokeColor.setStroke()
        path.lineWidth = lineWidth
        path.stroke()
    }
}

func text(_ value: String, rect: CGRect, size: CGFloat, weight: NSFont.Weight, color: NSColor, alignment: NSTextAlignment = .center) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = alignment
    let attributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: size, weight: weight),
        .foregroundColor: color,
        .paragraphStyle: paragraph,
    ]
    value.draw(in: rect, withAttributes: attributes)
}

func appIcon(size: Int, maskable: Bool) -> NSBitmapImageRep {
    image(width: size, height: size) { bounds in
        roundedRect(bounds, radius: 0, color: neutral)

        let safeInset = CGFloat(size) * (maskable ? 0.24 : 0.17)
        let markRect = bounds.insetBy(dx: safeInset, dy: safeInset)
        ellipse(markRect, fill: surface, stroke: stroke, lineWidth: CGFloat(size) * 0.014)

        let ringRect = markRect.insetBy(dx: CGFloat(size) * 0.105, dy: CGFloat(size) * 0.105)
        ellipse(ringRect, stroke: primary, lineWidth: CGFloat(size) * 0.038)

        let dot = CGFloat(size) * 0.07
        let dotRect = CGRect(
            x: bounds.midX - dot / 2,
            y: bounds.midY - CGFloat(size) * 0.235,
            width: dot,
            height: dot
        )
        ellipse(dotRect, fill: tertiary)

        let letterSize = CGFloat(size) * 0.28
        let letterRect = CGRect(
            x: bounds.minX,
            y: bounds.midY - letterSize * 0.42,
            width: bounds.width,
            height: letterSize * 1.05
        )
        text("D", rect: letterRect, size: letterSize, weight: .semibold, color: primary)
    }
}

func socialCard() -> NSBitmapImageRep {
    image(width: 1200, height: 630) { bounds in
        roundedRect(bounds, radius: 0, color: neutral)

        let iconSize: CGFloat = 176
        let iconFrame = CGRect(x: 92, y: 227, width: iconSize, height: iconSize)
        let icon = appIcon(size: Int(iconSize), maskable: false)
        icon.draw(in: iconFrame)

        text(
            "Dyana",
            rect: CGRect(x: 312, y: 330, width: 760, height: 92),
            size: 82,
            weight: .semibold,
            color: primary,
            alignment: .left
        )
        text(
            "Um timer calmo para meditar.",
            rect: CGRect(x: 318, y: 270, width: 760, height: 44),
            size: 32,
            weight: .regular,
            color: secondary,
            alignment: .left
        )
        text(
            "dayana-716b3.web.app",
            rect: CGRect(x: 318, y: 206, width: 760, height: 34),
            size: 22,
            weight: .medium,
            color: secondary,
            alignment: .left
        )

        tertiary.setFill()
        NSBezierPath(
            roundedRect: CGRect(x: 92, y: 136, width: 72, height: 6),
            xRadius: 3,
            yRadius: 3
        ).fill()
    }
}

let iconOutputs: [(String, Int, Bool)] = [
    ("app/web/favicon.png", 32, false),
    ("app/web/icons/Icon-180.png", 180, false),
    ("app/web/icons/Icon-192.png", 192, false),
    ("app/web/icons/Icon-512.png", 512, false),
    ("app/web/icons/Icon-maskable-192.png", 192, true),
    ("app/web/icons/Icon-maskable-512.png", 512, true),
]

for (path, size, maskable) in iconOutputs {
    writePNG(appIcon(size: size, maskable: maskable), to: path)
}

writePNG(socialCard(), to: "app/web/social-card.png")
