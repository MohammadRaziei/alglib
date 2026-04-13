# ![ALGLIB Logo](https://www.alglib.net/img/logo_3cubes_small.png) ALGLIB Unofficial Distribution (CMake/QMake Support)

[![GitHub release](https://img.shields.io/github/v/release/MohammadRaziei/ALGLIB)](https://github.com/MohammadRaziei/ALGLIB/releases)
[![License](https://img.shields.io/badge/license-GPL_2.0%2FGPL_3.0-orange)](./gpl2.txt)
[![Website](https://img.shields.io/badge/website-online-brightgreen)](https://mohammadraziei.github.io/ALGLIB)

Enhanced distribution of ALGLIB numerical analysis library with modern CMake/QMake support and pre-compiled binaries.

## Key Features

- 🏗 **Modern Build Systems**:
  - Full CMake integration
  - QMake project files for Qt developers
- 📦 **Pre-built Packages**:
  - Windows (32/64-bit DLL and static)
  - Linux (.so/.a)
  - macOS (.dylib Universal)
- 📜 **License Compliance**:
  - Includes original GPL 2.0 and 3.0 licenses
  - Maintains all original copyright notices
- 🧪 **Test Suite**:
  - Includes original test files (`test_*.cpp`)
  - Ready-to-build test projects

## Repository Structure

```
ALGLIB/
├── CMakeLists.txt          # Main CMake configuration
├── gpl2.txt               # GNU GPL 2.0 License
├── gpl3.txt               # GNU GPL 3.0 License
├── manual.cpp.html        # Enhanced documentation
├── src/                   # Original ALGLIB source
│   ├── *.cpp              # Core implementation
│   └── *.h               # Headers
└── tests/                 # Test cases
    └── test_*.cpp        # Original test files
```

## Quick Start

### Using CMake

```bash
git clone https://github.com/MohammadRaziei/ALGLIB.git
cd ALGLIB
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
```

### Using Pre-built Libraries

Download from [Releases](https://github.com/MohammadRaziei/ALGLIB/releases) and link to your project.

## Licensing

This distribution maintains ALGLIB's original licensing terms:
- [GNU GPL 2.0](./gpl2.txt)
- [GNU GPL 3.0](./gpl3.txt)

❗ **Important**: Commercial use may require a separate license from the [official ALGLIB website](https://www.alglib.net).

## Documentation

- [Enhanced Manual](./manual.cpp.html)
- [Official Documentation](https://www.alglib.net/docs.php)

## Website

Full project details:  
[https://mohammadraziei.github.io/alglib](https://mohammadraziei.github.io/alglib)

## Disclaimer

⚠️ This is an **unofficial** distribution that:
- Preserves all original source code unchanged
- Adds only build system improvements
- Maintains all original licensing terms

For the official version, visit: [www.alglib.net](https://www.alglib.net)

## Support

For issues with this distribution:  
[Open a GitHub Issue](https://github.com/MohammadRaziei/ALGLIB/issues)

For ALGLIB functionality questions:  
Contact [official support](https://www.alglib.net)
