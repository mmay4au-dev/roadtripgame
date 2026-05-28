# WAYPIN Road Trip Game Agent Guide

## Product Vision

WAYPIN Road Trip Game turns real-world drives into a shared multiplayer road trip game. Everyone in the car can join on their own device, take passenger-safe roles, complete route-aware challenges, and build a shared trip timeline.

The app should feel like a map-first road trip companion for interstate driving, city driving, suburbs, small towns, rural roads, scenic routes, and off-the-beaten-path exploration.

## Development Principles

- Build a clean SwiftUI iOS foundation before adding gameplay complexity.
- Prefer small, readable types over broad abstractions.
- Keep mock data and static engines easy to replace with real services later.
- Treat map, trip session, challenge, and timeline features as separate domains.
- Keep UI passenger-first and safe for use in a moving vehicle.
- Avoid introducing backend, AI, or real-time dependencies until the MVP shell is stable.

## Repo Structure Expectations

The initial app source should live under `WAYPINRoadTripGame/`:

- `App/`: App entry point, root navigation, dependency composition.
- `Models/`: Lightweight domain models and enums.
- `ViewModels/`: Observable state for SwiftUI views.
- `Views/`: SwiftUI screens and reusable view components.
- `Views/Onboarding/`: First-run and role-selection flows.
- `Views/Trip/`: Create trip, join trip, and active trip dashboard screens.
- `Views/Challenges/`: Challenge lists, detail views, and completion flows.
- `Views/Map/`: Map-first trip companion surfaces.
- `Views/Timeline/`: Shared trip timeline and trip recap surfaces.
- `Views/Profile/`: Player identity, preferences, and settings.
- `Services/Location/`: Location permission and future route context services.
- `Services/ChallengeEngine/`: Mock and future route-aware challenge engines.
- `Services/TripSession/`: Trip creation, joining, and future sync services.
- `MockData/`: Static data used by previews and early development.
- `Utilities/`: Small shared helpers.
- `Resources/`: App assets, colors, strings, and bundled content.

## SwiftUI Coding Conventions

- Use `struct` views with focused responsibilities.
- Keep view bodies readable by extracting private computed views when needed.
- Prefer `NavigationStack`, `TabView`, and standard SwiftUI controls unless there is a clear product reason to customize.
- Use previews with mock data once the Xcode project exists.
- Keep view state local with `@State` until it belongs in a view model.
- Use `@StateObject` for view-owned observable models and `@ObservedObject` for injected models.
- Avoid large view files that mix layout, business rules, and data generation.

## MVVM Guidance

- Models should be simple domain values with minimal behavior.
- View models should own screen state, user intents, and calls into services.
- Services should expose replaceable interfaces or focused concrete types.
- Mock services should be deterministic and easy to use in previews.
- Do not let SwiftUI views create complex gameplay logic directly.
- Avoid premature protocols. Introduce them when multiple implementations are needed.

## Safety Rules For Driver And Passenger Interaction

- The driver should not be the primary player.
- Interactive gameplay is designed for passengers.
- Driver mode should eventually be audio-first, minimal, and glance-free.
- Avoid time-pressure interactions that could encourage unsafe behavior.
- Avoid visual prompts that require the driver to read, tap, or make decisions while driving.
- Any location-aware challenge must be safe to ignore.
- Challenges should never encourage illegal, risky, distracting, or harassing behavior.
- Passenger roles may interact with the map, trivia, scavenger hunts, camera prompts, and timeline features.

## MVP Scope Boundaries

The MVP foundation should include:

- SwiftUI iOS app structure.
- Map-first trip companion shell.
- Create trip and join trip flows using mock session data.
- Passenger role selection.
- Static/mock challenge engine.
- Active trip dashboard.
- Shared timeline placeholder.
- Clean documentation and repo conventions.

## What Not To Build Yet

Do not add these until explicitly scoped:

- Firebase or other backend services.
- AI integration or generated trivia.
- Real-time multiplayer sync.
- Complex MapKit routing or navigation.
- Cross-car social features.
- Push notifications.
- Payments, accounts, or authentication.
- Production analytics.
- Driver gameplay that requires visual interaction.

## Build And Test Expectations

- Keep files compile-safe once an Xcode project exists.
- Add unit tests when business logic appears in services or view models.
- Add preview-friendly mock data for new UI.
- Run the app in Xcode after creating or modifying the project file.
- Prefer small commits that preserve a working app state.

## Definition Of Done

A task is done when:

- The implementation matches the requested scope without overbuilding.
- New files follow the expected folder structure.
- Mock data is clearly separated from future real services.
- Swift code is formatted, readable, and compile-safe.
- Safety implications are considered for driver and passenger behavior.
- README and agent guidance stay accurate when project structure changes.
- The next coding task is clear.

## Future Roadmap Guardrails

- Route-aware challenges should build on a replaceable challenge engine, not hard-coded view logic.
- Multiplayer should be introduced through a trip session service boundary.
- AI-generated trivia and local stories should be optional, reviewable, and safe.
- Cross-car social features should wait until single-car sessions are fun and stable.
- Driver mode should be designed separately from passenger gameplay.
- The timeline should become a shared memory layer, not just a log of events.
