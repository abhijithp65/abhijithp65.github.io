# Personal Portfolio 🌐

A modern **Flutter Web portfolio** built using **Flutter + Riverpod + Clean Architecture**.
This website showcases my projects, skills, and GitHub repositories dynamically using the GitHub API.

The site is automatically deployed using **GitHub Actions CI/CD** to **GitHub Pages**.

🔗 **Live Website:**
https://abhijithp65.github.io

---

# 🚀 Features

* Responsive Flutter Web UI
* Clean Architecture structure
* State management using Riverpod
* GitHub API integration to fetch repositories
* Automatic deployment with CI/CD
* Modern UI with smooth animations
* Fully responsive for desktop and mobile

---

# 🛠 Tech Stack

* **Flutter Web**
* **Dart**
* **Riverpod**
* **GitHub API**
* **GitHub Actions (CI/CD)**
* **GitHub Pages Hosting**

---

# 📂 Project Structure

```
lib
 ├ core
 │   ├ constants
 │   ├ theme
 │   └ utils
 │
 ├ features
 │   ├ portfolio
 │   │   ├ data
 │   │   │   ├ datasource
 │   │   │   ├ models
 │   │   │   └ repositories
 │   │   ├ domain
 │   │   │   ├ entities
 │   │   │   └ usecases
 │   │   └ presentation
 │   │       ├ providers
 │   │       ├ screens
 │   │       └ widgets
 │
 └ main.dart
```

---

# ⚙️ CI/CD Deployment

This project uses **GitHub Actions** to automatically:

1. Install Flutter
2. Fetch dependencies
3. Build Flutter Web
4. Deploy to GitHub Pages

Every push to the `main` branch automatically updates the live site.

Workflow file:

```
.github/workflows/deploy.yml
```

---

# 📸 Screenshots

## 🏠 Home Page

![Home Screenshot](screenshots/home.png)

## 💻 Projects Section

![Projects Screenshot](screenshots/projects.png)

## 📱 Responsive Layout

![Responsive Screenshot](screenshots/responsive.png)

---

# 🧑‍💻 Running Locally

Clone the repository:

```
git clone https://github.com/abhijithp65/abhijithp65.github.io.git
```

Navigate to the project:

```
cd personal_portfolio
```

Install dependencies:

```
flutter pub get
```

Run the web app:

```
flutter run -d chrome
```

---

# 📡 GitHub API Integration

Repositories are fetched dynamically using:

```
https://api.github.com/users/abhijithp65/repos
```

This allows the portfolio to automatically display newly added projects.

---

# 👨‍💻 Author

**Abhijith P**

Flutter Developer

GitHub:
https://github.com/abhijithp65

---

# ⭐ Support

If you like this project, please consider giving it a **star ⭐ on GitHub**.
It helps and motivates me to build more open-source projects.

---
