import Combine
import SwiftUI

struct Flower: View {
  
  @State var open: Double = 1
  
  let r: CGFloat = 120
  var numberOfPetals: Int = 6
  
  var pelletRotation: Double {
    360 / Double(numberOfPetals)
  }
  var pelletSize: CGFloat {
    r * CGFloat(minSize * (1 - open) + open)
  }
  private let opacity = 0.4
  private let maxOffset = 0.42
  private let minSize = 0.42
  private var timePeriod = 2.4
  private let color1 = Color.red
  private let color2 = Color.orange
  
  var body: some View {
    let content = ZStack {
      ForEach(0..<numberOfPetals) { idx in
        Circle()
          .foregroundColor(.white)
          .frame(width: self.pelletSize, height: self.pelletSize)
          .offset(CGSize(width: self.r * CGFloat(self.maxOffset * self.open), height: 0))
          .rotationEffect(Angle(degrees: (Double(idx) + self.open) * self.pelletRotation))
          .opacity(self.opacity)
          .onAppear {
            withAnimation(Animation.easeInOut(duration: self.timePeriod).repeatForever()) {
              self.open = self.open == 1 ? 0 : 1
            }
          }
        }
    }
    let gradient = LinearGradient(gradient: Gradient(colors: [self.color1, self.color2]), startPoint: .bottomLeading, endPoint: .topTrailing)
      .frame(width: r * (1 + CGFloat(maxOffset)) * 2, height: r * (1 + CGFloat(maxOffset)) * 2)
    return content.overlay(gradient.colorMultiply(Color.white.opacity(open * 0.3 + 0.7))).mask(content)
  }
}


struct ContentView: View {
    var body: some View {
      ZStack {
        Color.black.frame(width: 300, height: 300)
        Flower()
      }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
      .frame(width: 300, height: 300)
    }
}
