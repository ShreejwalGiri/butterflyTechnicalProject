# butterflyTechnicalProject

# ButterflyShreejwalGiri

## Instructions for Setting Up the Project

### Step 1: Open Project in Xcode
- Navigate to the project folder.
- Open `ButterflyShreejwalGiri.xcworkspace` file using Xcode.

### Step 2: Access Project Folder in Terminal
- Open Terminal.
- Navigate to the project folder using the `cd` command:


### Step 3: Install Pods
- Once you're in the project folder in Terminal, type the following command to install pods:


### Step 4: Build and Run
- After installing pods, you can now build and run the project in Xcode.


## Project Overview and Development Decisions

### Decisions Made During App Development

- **SOLID Principle**: Developed the app adhering to the SOLID principles (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion) to ensure code maintainability, scalability, and reusability.

- **Coordinator for Navigation**: Utilized the coordinator pattern for navigation management, enhancing code modularity and separation of concerns. Coordinators handle navigation logic independently from view controllers, facilitating easier navigation flow management.

- **RxSwift Integration**: Integrated RxSwift to leverage reactive programming paradigms, enhancing code readability, and maintainability. Utilized RxSwift along with RxCocoa for reactive bindings, enabling seamless data flow and event handling within the app.

- **UI Testing**: Conducted UI testing to ensure the app's user interface functions correctly and remains consistent across different devices and iOS versions. UI testing was performed using XCTest framework, ensuring robustness and reliability of the app's UI components.

- **Third-Party Libraries**:
  - Alamofire: Used for simplified and efficient networking, enabling seamless communication with backend services.
  - HandyJSON: Leveraged for easy JSON parsing and model mapping, simplifying data serialization and deserialization processes.
  - RxAlamofire: Integrated for combining the power of Alamofire with RxSwift, enabling reactive networking operations.
  - ReachabilitySwift: Employed for monitoring network reachability status, ensuring the app responds appropriately to network connectivity changes.
  - LBTATools: Utilized for UI layout and styling enhancements, providing a set of tools and extensions for UIKit components.
  - IQKeyboardManager: Integrated for managing keyboard appearance and behavior, improving user experience during text input.
  - SDWebImage: Used for asynchronous image loading and caching, optimizing performance and memory usage when dealing with image assets.


### Challenges Faced and Solutions

- **API Service Challenges**: Faced challenges with integrating API services asynchronously, leading to issues such as data retrieval delays and UI freezing. Overcame by adopting RxAlamofire, which seamlessly combines RxSwift with Alamofire, enabling asynchronous and reactive network requests. This approach ensured smooth data fetching without blocking the main thread, enhancing app responsiveness and user experience.

- **Keyboard Issues**: Encountered issues related to keyboard management, such as keyboard overlapping content or unexpected keyboard dismissal. Resolved by integrating IQKeyboardManager, which automatically manages keyboard appearance and behavior, ensuring that the keyboard does not obscure relevant content and providing a smoother text input experience for users.

- **Network Validation Issues**: Faced challenges in handling network connectivity changes and validating network availability within the app. Overcame by incorporating ReachabilitySwift, which offers a robust solution for monitoring network reachability status. This allowed the app to respond appropriately to network changes, providing feedback to users and adjusting functionality based on network availability, thus enhancing overall reliability and user satisfaction.


