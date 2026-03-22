# Stock Watchlist Assignment

A Flutter application demonstrating a stock watchlist with drag-and-drop reordering functionality, built using the BLoC (Business Logic Component) architecture pattern.

## 🚀 Project Overview

The goal of this project is to allow users to manage multiple watchlists and reorder stocks within those lists seamlessly. The application focuses on high-quality UI/UX, responsiveness, and a robust state management implementation.

## 🛠️ Approach & Implementation

### 1. State Management (BLoC)
I chose the **BLoC pattern** to ensure a strict separation between the business logic and the UI.
- **Events**: Defined clear actions like `HomeScreenInitialEvent`, `HomeScreenTabChangeEvent`, and `HomeScreenReorderEvent`.
- **States**: Used a state-driven approach (`Initial`, `Loaded`, `TabChange`) to represent the UI at any given moment.
- **Bloc**: The `HomeScreenBloc` manages the master data. When a reorder occurs, the BLoC performs a deep copy of the data, modifies the list, and emits a new state. This ensures **immutability** and prevents side effects.

### 2. Data Modeling & Type Safety
- **Immutable Models**: All data models (`WatchlistData`, `Watchlist`, `WatchlistItem`) extend `Equatable`. This allows the BLoC to compare states efficiently and only trigger rebuilds when the data actually changes.
- **Type Safety**: Used strong typing throughout the project to minimize runtime errors and improve code maintainability.

### 3. Reordering Logic
Implementing `ReorderableListView` requires careful handling of indices:
- When an item is moved down the list, the destination index shifts. I implemented logic within the BLoC to adjust the `newIndex` correctly (`if (newIndex > oldIndex) newIndex -= 1`), ensuring the item lands exactly where the user dropped it.

### 4. UI/UX & Responsiveness
- **Material 3**: Leveraged Material 3 design principles for a modern look and feel.
- **Visual Feedback**: Used Cards with elevation and clear typography to make the stock information readable.
- **Responsive Layout**: The app uses a flexible layout that adapts to different screen sizes, using `Expanded` and `TabBarView`.

## 📂 Project Structure

```text
lib/
├── main.dart               # Entry point and App configuration
├── model/
│   └── watch_list_model.dart # Type-safe data models (Immutable)
└── home_screen/
    ├── home_screen.dart    # UI Layer (Stateless & Stateful Views)
    ├── home_screen_bloc/
    │   └── home_screen_bloc.dart # Business logic handler
    ├── home_screen_event/
    │   └── home_screen_event.dart # Defined user actions
    └── home_screen_state/
        └── home_screen_state.dart # Defined UI states
```

## ⚙️ Key Dependencies

- `flutter_bloc`: For predictable state management.
- `equatable`: To simplify object comparison and optimize rebuilds.

## 🏃 How to Run

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```

---
**Note**: This project was developed with a focus on clean code practices, including the removal of production print statements and proper resource disposal (Closing BLoCs and disposing of controllers).
