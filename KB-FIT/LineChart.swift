import SwiftUI

struct LineChart: View {
    var data: [Double]
    private var maxValue: Double { data.max() ?? 0 }
    private var minValue: Double { data.min() ?? 0 }

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width * CGFloat(index) / CGFloat(data.count - 1)
                    let yPosition = geometry.size.height * CGFloat(1 - (data[index] - minValue) / (maxValue - minValue))
                    let point = CGPoint(x: xPosition, y: yPosition)

                    if index == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart(data: [300, 500, 700, 450, 600, 800, 750])
            .frame(height: 200)
            .padding()
    }
}
