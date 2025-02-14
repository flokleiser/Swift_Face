import SwiftUI
import ClockKit

struct PocketWatchFace: View {
    @State private var currentTime = Date()
    
    var body: some View {
        ZStack {
            Image("pocket_watch_background") // TODO: shaders
                .resizable()
                .scaledToFit()
            
            ClockHands()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                currentTime = Date()
            }
        }
    }
}

struct ClockHands: View {
    @State private var currentTime = Date()
    
    var body: some View {
        ZStack {
            
            //ref
            drawLineRef(lineRotation: 90)
            drawLineRef(lineRotation: 0)
            drawLineRef(lineRotation: 30)
            drawLineRef(lineRotation: 60)
            drawLineRef(lineRotation: 120)
            drawLineRef(lineRotation: 150)
                
            
            // Hour markers
            
            RoundedRectangle(cornerSize:CGSize(width: 8, height: 8))
                .opacity(0.3)
                .frame(width: 7, height:40)
                .offset(y:95)
            
            RoundedRectangle(cornerSize:CGSize(width: 8, height: 8))
                .opacity(0.3)
                .frame(width: 7, height:40)
                .offset(y:-110)
            
            RoundedRectangle(cornerSize:CGSize(width: 8, height: 8))
                .opacity(0.3)
                .frame(width: 40, height:7)
                .offset(x:83)

            RoundedRectangle(cornerSize:CGSize(width: 8, height: 8))
                .opacity(0.3)
                .frame(width: 40, height:7)
                .offset(x:-83)
            
            RoundedRectangle(cornerSize:CGSize(width: 8, height: 8))
                .opacity(0.3)
                .frame(width: 40, height:7)
                .offset(x:-83)
                .rotationEffect(.degrees(30), anchor: .center)
            
            RoundedRectangle(cornerSize:CGSize(width: 8, height: 8))
                .opacity(0.3)
                .frame(width: 40, height:7)
                .offset(x:-84)
                .rotationEffect(.degrees(60), anchor: .center)




            
            
            // Hour Hand
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                .frame(width: 7, height: 80)
                .offset(y: -40)
                .rotationEffect(.degrees(hourAngle()), anchor: .center)
            
            // Minute Hand
            RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                .frame(width: 5, height: 110)
                .offset(y: -55)
                .rotationEffect(.degrees(minuteAngle()), anchor: .center)
            
            // Second Hand
            RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                .frame(width: 2, height: 100)
                .offset(y: -50)
                .rotationEffect(.degrees(secondAngle()), anchor: .center)

        }
    }
    
    func hourAngle() -> Double {
        let calendar = Calendar.current
        let hour = Double(calendar.component(.hour, from: currentTime) % 12)
        let minute = Double(calendar.component(.minute, from: currentTime))
        return (hour / 12.0) * 360.0 + (minute / 60.0) * 30.0
    }
    
    func minuteAngle() -> Double {
        let calendar = Calendar.current
        let minute = Double(calendar.component(.minute, from: currentTime))
        return (minute / 60.0) * 360.0
    }
    
    func secondAngle() -> Double {
        let calendar = Calendar.current
        let second = Double(calendar.component(.second, from: currentTime))
        return ( second / 60.0 ) * 360.0;
    }
    
    
    func drawLineRef(lineRotation: Double) -> some View {
        return (
        Rectangle()
            .frame(width: 5,height:500)
            .opacity(0.1)
            .rotationEffect(Angle(degrees: lineRotation))
        )
    }

}

#Preview {
    PocketWatchFace()
}
