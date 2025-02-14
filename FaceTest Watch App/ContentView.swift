import SwiftUI
import ClockKit

struct PocketWatchFace: View {
    @State private var currentTime = Date()
    
    var body: some View {
        ZStack {
            Image("pocket_watch_background") // Add your watch face image
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
            
            // Hour markers
            RoundedRectangle(cornerSize:CGSize(width: 3, height: 3))
                .opacity(0.3)
            
            
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

}

#Preview {
    PocketWatchFace()
}
