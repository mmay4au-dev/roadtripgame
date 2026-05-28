# WAYPIN Road Trip Game

WAYPIN Road Trip Game turns real-world drives into a shared, passenger-first multiplayer game.

## Product Overview

WAYPIN is a SwiftUI iOS road trip companion that helps people in the same car join a shared trip session, take passenger-safe roles, complete road-aware challenges, and build a shared timeline of the drive.

The first build should establish the product shape without overbuilding gameplay. Early versions use mock data and static challenges while leaving clear room for route-aware challenges, real-time sessions, cross-car social play, and AI-generated local stories later.

## MVP Features

- Map-first road trip companion shell.
- Create a shared trip session.
- Join a trip by code.
- Passenger role selection.
- Active trip dashboard.
- Static/mock challenge list.
- Placeholder map experience.
- Placeholder shared trip timeline.
- Mock data-first development.

## Current Build Phase

Initial repo structure and documentation. No Xcode project has been generated yet.

## Planned App Tabs And Screens

- Home: Create a new trip or join an existing trip.
- Join Trip: Enter a trip code and passenger identity.
- Active Trip: View current trip status, participants, and active prompts.
- Challenges: Browse and complete mock road trip challenges.
- Map: Map-first trip companion view.
- Timeline: Shared trip moments and future recap.
- Profile: Player role, preferences, and future settings.

## Tech Stack

- Swift
- SwiftUI
- iOS
- MVVM
- Mock services and static data for the first phase
- Future: MapKit, trip session sync, route-aware challenge services, AI-generated trivia

## Safety Notes

The driver should not be the primary player. Interactive gameplay should be designed for passengers. Driver mode should eventually be audio-first, minimal, and safe to ignore.

Challenges must not encourage distracted driving, risky behavior, illegal actions, or unsafe interactions with people outside the car.

## Roadmap Phases

1. Foundation: Repo structure, docs, models, mock data, and SwiftUI shell.
2. MVP Shell: Create trip, join trip, active trip dashboard, mock challenges, placeholder map, and timeline.
3. Local Gameplay: Role-based challenge flows, scoring, trip recap, and richer mock session state.
4. Route Awareness: Location context, basic road type awareness, and safe route-aware challenge selection.
5. Shared Sessions: Real-time sync, participant presence, and resilient trip session state.
6. Story Layer: AI-generated trivia, local stories, and route-aware content with safety filters.
7. Social Layer: Cross-car sharing, trip highlights, and optional group discovery.

## How To Run Once The Xcode Project Exists

1. Open the generated `.xcodeproj` or `.xcworkspace` in Xcode.
2. Select an iOS simulator or connected device.
3. Build and run the `WAYPIN Road Trip Game` app target.
4. Use mock trip and challenge data until backend services are added.

No Firebase, AI integration, real-time multiplayer, or complex MapKit routing is part of the current phase.
