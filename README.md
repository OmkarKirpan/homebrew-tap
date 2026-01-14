# OmkarKirpan's Homebrew Tap

This is a custom Homebrew tap for installing software created by Omkar Kirpan.

## Installation

Tap this repository:

```bash
brew tap OmkarKirpan/homebrew-tap
```

## Available Formulae

### BrewBar

Native macOS menubar app for managing Homebrew services.

**Installation:**

```bash
brew install brewbar
```

**Usage:**

```bash
brewbar
```

This launches the BrewBar menubar application that provides a convenient interface for managing Homebrew services directly from your macOS menubar.

**More Information:**
- [BrewBar GitHub Repository](https://github.com/omkarkirpan/BrewBar)

## Development

### Testing Formulae Locally

To test a formula from this tap locally:

```bash
# Tap from local directory
brew tap OmkarKirpan/homebrew-tap /path/to/homebrew-tap

# Install from source
brew install --build-from-source brewbar

# Run tests
brew test brewbar

# Audit formula
brew audit --strict --online brewbar
```

### Contributing

If you encounter any issues or have suggestions for improvements, please open an issue on the [GitHub repository](https://github.com/OmkarKirpan/homebrew-tap).

## Requirements

- macOS Ventura (13.0) or later
- Xcode 14.0 or later (for building from source)

## License

See individual formula files for licensing information.
