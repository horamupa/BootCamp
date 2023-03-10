//
//  OnboardingView.swift
//  BootCamp
//
//  Created by MM on 22.12.2022.
//

import SwiftUI

struct OnboardingView: View {
    //Onboarding state
    /*
     0 - Welcome screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))]),
                center: .topLeading, startRadius: 200, endRadius: 600)
            .ignoresSafeArea()
            VStack {
                switch onboardingState {
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    welcomeSection1
                        .transition(transition)
                case 2:
                    welcomeSection2
                        .transition(transition)
                default:
                    welcomeSection
                }
                
                Spacer()
                bottomButton
            }
            
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

// MARK: Components

extension OnboardingView {
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            ZStack(alignment: .bottomLeading) {
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color(#colorLiteral(red: 0.9559542537, green: 0.5613597035, blue: 0.4460546374, alpha: 1)))
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
            }
            .background {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white.opacity(0.2))
                    .blur(radius: 10)
                    
            }
            Text("Осознанность")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
                .overlay(alignment: .bottom) {
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundColor(.black.opacity(0.7))
                }
            Text("Медитируйте с приложением ми-ша для достижения наилучших результатов и что бы всё было заебок")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding(.top, 10)
                .padding(.horizontal, 40)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
    private var welcomeSection1: some View {
        VStack(spacing: 40) {
            Spacer()
            ZStack(alignment: .bottomLeading) {
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color(#colorLiteral(red: 0.9559542537, green: 0.5613597035, blue: 0.4460546374, alpha: 1)))
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
            }
            .background {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white.opacity(0.2))
                    .blur(radius: 10)
                    
            }
            Text("Просто!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
                .overlay(alignment: .bottom) {
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundColor(.black.opacity(0.7))
                }
            Text("Просто сядь, запусти медитацию и дальше мы проведём тебя по самому оптимальному пути")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding(.top, 10)
                .padding(.horizontal, 40)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
    private var welcomeSection2: some View {
        VStack(spacing: 40) {
            Spacer()
            ZStack(alignment: .bottomLeading) {
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color(#colorLiteral(red: 0.9559542537, green: 0.5613597035, blue: 0.4460546374, alpha: 1)))
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)))
            }
            .background {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white.opacity(0.2))
                    .blur(radius: 10)
                    
            }
            Text("Понятно")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
                .overlay(alignment: .bottom) {
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundColor(.black.opacity(0.7))
                }
            Text("Древние техники в сочетании с самыми последними методиками, просто наслаждайся")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding(.top, 10)
                .padding(.horizontal, 40)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
    
    private var bottomButton: some View {
        Text(onboardingState == 2 ? "Приступим" : "Дальше")
            .font(.headline)
            .foregroundColor(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background()
            .cornerRadius(25)
            .padding()
            .animation(nil)
            .onTapGesture {
                nextOnboardingStep()
            }
    }
}

// MARK: Functions

extension OnboardingView {
    
    func nextOnboardingStep() {
        withAnimation(.spring()) {
            if onboardingState == 2 {
                //do something
            } else {
                onboardingState += 1
            }
        }
    }
    
    func finishOnboarding() {
         
    }
    
}
