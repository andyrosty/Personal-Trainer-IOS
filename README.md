# Personal Trainer

Personal Trainer is a SwiftUI fitness companion aimed at beginners and hobby athletes.  It generates personalised workout + meal plans via an AI backend and helps you stay consistent with a clean, dark-mode-only interface.

## Highlights

• **Dark-mode first** – the app always launches in dark appearance for better battery life and modern aesthetics.
• **Five-tab layout**
  1. **Home** – today's workout, meal plan, progress bar and quick action to *Log Workout*.
  2. **Plans** – 7-day calendar view of your AI-generated workout & diet schedule.
  3. **Progress** – weight chart, workout streaks and achievements (via Swift Charts).
  4. **AI Coach** – chat to your personal coach for tips or plan adjustments.
  5. **Profile** – manage personal data, dietary restrictions, units and notifications.
• **Custom font** – Barlow Condensed Thin adds a sporty flavour to headings.
• **Minimal colour palette** – system colours that adapt automatically to dark mode.

## Requirements

* iOS 15+ (SwiftUI 3)
* Xcode 15+

## Installation

```bash
# Clone the repo
$ git clone https://github.com/your-org/Personal-Trainer-iOS.git
$ cd Personal-Trainer-iOS

# Open in Xcode
$ open "Personal Trainer.xcodeproj"
```

### Configure the backend
Edit `NetworkManager.swift` and set `baseURL` to your API endpoint.

### Custom font bundle
The font file `BarlowCondensed-Thin.ttf` lives in the root of the app target and is listed under **UIAppFonts** in *Info.plist* – no extra steps required.

## Usage

1. Build & run on simulator or device (the app enforces dark mode automatically).
2. Home tab – tap **Start Workout** or **Log Workout** after you complete one.
3. Switch to **Plans** to browse the week's workouts/meals.
4. Track progress in **Progress** or chat with the **AI Coach** for guidance.
5. Update personal details or units in **Profile**.

## Project structure

```
.
├── Personal Trainer/           # Main SwiftUI code
├── Personal Trainer.xcodeproj  # Xcode project
├── Personal TrainerTests/      # Unit tests
├── Personal TrainerUITests/    # UI tests
└── README.md
```

## Contributing

Pull requests are welcome!  Please open an issue first if you'd like to discuss a major change.