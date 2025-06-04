# WallaMarvel

A simple iOS app that fetches and displays a list of Marvel superheroes, built as part of the Wallapop iOS technical test.
<br/><br/>

## ✨ Features

- List of Marvel superheroes
<br/><br/>

## 🛠️ Setup

### Local Configuration

This project uses a `.xcconfig` file (`Config.xcconfig`) to store sensitive information like API keys. To get started:

1. Copy the example file:
```
cp ConfigExample.xcconfig Config.xcconfig

```

2. Open `Config.xcconfig` and fill in the required values
<br/>

> [!NOTE]
> Config.xcconfig is ignored by git (see .gitignore) to keep sensitive data out of version control.
<br/>

### SwiftLint

This project uses [SwiftLint](https://github.com/realm/SwiftLint) to ensure a consistent Swift style.
<br/><br/>

#### Installation:

Install via Homebrew:
```
brew install swiftlint

```

Or follow the installation instructions on the SwiftLint repository.
<br/><br/>

#### Usage:

**Automatic linting and autocorrection**: SwiftLint runs automatically during build via a **Run Script Phase** in Xcode:

```
export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint; then
    swiftlint —-fix && swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

```

This script:
- Runs **autocorrection** first (`--fix`)  
- Then runs the regular lint checks  
- Issues a warning if SwiftLint is not installed
<br/><br/>

**Manual linting**: You can also run it manually in your terminal:
```
swiftlint –fix && swiftlint

```

#### Configuration

The configuration file is `.swiftlint.yml` located at the root of the project. You can customize `.swiftlint.yml` further to suit your needs.
<br/><br/>

> [!IMPORTANT]
> SwiftLint is **required** to build the project cleanly. If you don’t have it installed, the script will warn you.
<br/>

## 📄 License

This project is for technical test and learning purposes only.
