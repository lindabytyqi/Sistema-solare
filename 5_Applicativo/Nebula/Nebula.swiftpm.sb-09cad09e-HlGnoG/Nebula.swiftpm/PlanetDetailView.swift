import SwiftUI
import AVKit

struct PlanetDetailView: View {
    var planet: Planet
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Benvenuto su \(planet.name)")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .minimumScaleFactor(0.7)
                
                Image(planet.name)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250)
                    .shadow(radius: 10)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(planet.details, id: \.self) { paragraph in
                        Text(paragraph)
                            .font(.system(size: 18, design: .rounded))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(6)
                            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 80 : 20)
                            .minimumScaleFactor(0.8)
                    }
                }
                
                if let video = planet.video {
                    if let url = Bundle.main.url(forResource: video.url.replacingOccurrences(of: ".mp4", with: ""), withExtension: "mp4") {
                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(width: 420, height: 250) 
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .padding()
                    } else {
                        Text("Video non trovato")
                            .foregroundColor(.red)
                    }
                }
                
                Spacer(minLength: 10)
            }
            .frame(maxWidth: .infinity)
        }
        .background(
            Image("sfondo2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}
import AVKit

struct VideoButton: View {
    let localVideoURL: URL
    let title: String
    @State private var showPlayer = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                showPlayer = true
            }) {
                Label(title, systemImage: "play.circle.fill")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .sheet(isPresented: $showPlayer) {
                VideoPlayer(player: AVPlayer(url: localVideoURL))
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
