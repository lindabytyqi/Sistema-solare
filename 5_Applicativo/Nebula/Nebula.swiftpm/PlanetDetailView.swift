import SwiftUI

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
                    Link(destination: URL(string: video.url)!) {
                        Text(video.title ?? "Guarda il video")
                            .foregroundColor(.blue)
                            .font(.headline)
                            .padding(.top, 10)
                            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 80 : 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Spacer(minLength: 40)
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
