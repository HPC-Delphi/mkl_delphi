# mkl_delphi - Intel MKL Wrapper for Delphi Integration

`mkl_delphi` is a dynamic library written in C, providing a foundation for integrating the Intel Math Kernel Library (MKL) into Delphi applications. It currently exposes the highly optimized CBLAS `cblas_dgemm` routine and serves as an open-source template for expanding Delphi-MKL interoperability in High-Performance Computing (HPC) environments.

## Features

- **Intel MKL Integration**: Provides C binding to Intel MKL's industry-standard CBLAS `cblas_dgemm` routine, unlocking maximum hardware performance for dense linear algebra.
- **Delphi Wrapper**: Includes a meticulously crafted Delphi wrapper (`MKL.pas`) that utilizes `$Z4` binary-compatible enumerations for seamless and safe C-to-Delphi communication.
- **Extensible Architecture**: Designed as a robust, open-source starting point, allowing developers to easily add wrappers for additional MKL functions as needed.
- **High-Performance Computing**: Enables hardware-optimized computations for improved performance in intense algebraic tasks.
- **Cross-Language Compatibility**: Distributed as a DLL, accessible from various programming environments.

## Requirements & Development Environment

The library is developed, tested, and intended to be used in the following environment:
- **Operating System**: Windows 11 (64-bit)
- **Compiler**: Intel C++ Compiler (`icx-cc`)
- **Toolchain**: Microsoft Visual Studio Build Tools (`nmake`)
- **Dependencies**: Intel Math Kernel Library (MKL) for headers (`mkl_cblas.h`) and linked binaries.
- **Delphi Integration**: RAD Studio (Delphi 12.1 Community Edition)

### Toolchain Setup and Installation Steps

Unlike standard GCC setups, compiling against Intel MKL on Windows requires the official Intel oneAPI toolkit and Microsoft's build tools. Follow these steps carefully:

**1: Install MSVC Build Tools (for `nmake`)**

* Navigate to the [Visual Studio Downloads page](https://visualstudio.microsoft.com/es/downloads/ "null").
    
* Scroll down to the **"Tools for Visual Studio"** section and download the installer for **Build Tools for Visual Studio 2026** (the version year may vary depending on the current release).
    
* Open the downloaded `vs_BuildTools.exe` installer.
    
* In the workloads tab, check the box for **Desktop development with C++**.
    
* In the installation details column on the right, ensure that **MSVC Build Tools for x64/x86 (latest)** is checked.
    
* Click **Install**.
    
* Once installed, open the **Developer Command Prompt for VS** from your Windows start menu and type `nmake /?`. If the help text appears, the installation was successful.

**2: Install Intel oneAPI Toolkit (for `icx` and MKL)**

* Navigate to the [Intel oneAPI Toolkit Download page](https://www.intel.com/content/www/us/en/developer/tools/oneapi/oneapi-toolkit-download.html "null").
    
* Click on "Continue as Guest..." to download the offline or online installer.
    
* Run the installer. When prompted to select components, ensure that both the **Intel C++ Compiler (`icx`)** and the **Intel Math Kernel Library (MKL)** are selected for installation.
    
* Proceed with the default installation paths.

## Project Structure

```
mkl_delphi/
│
├── build/             # Compiled binaries and intermediate files
├── include/           # Public API headers (C)
│   └── mkl_delphi.h
├── interface/         # Delphi wrapper
│   └── MKL.pas
├── src/               # C source code
│   └── mkl_delphi.c
├── LICENSE            # License information
├── Makefile           # Build script for DLL
└── README.md          # Project documentation
```

## Compilation Instructions

Once your build tools and Intel MKL are properly installed, you must initialize the Intel environment variables before compiling:

1. Open a **Developer Command Prompt** (installed during "1: Install MSVC Build Tools (for `nmake`)").
    
2. Initialize the Intel oneAPI environment variables by running the `setvars.bat` script. Execute the following command (adjust the path if you installed oneAPI in a custom directory):
```
"C:\Program Files (x86)\Intel\oneAPI\setvars.bat"
```
    
3. Navigate to the root directory of this repository:
```
cd path\to\mkl_delphi
```
    
4. Run the build tool to compile the DLL:
```
nmake
``` 

This will generate `mkl_delphi.dll` in the `build\` directory.

## Using the Library in Delphi

### 1. Linking the DLL (Choose One Method)

To allow your Delphi application to load and communicate with the dynamic library, you must make `mkl_delphi.dll` (and the underlying MKL runtime DLLs) discoverable by Windows. You can achieve this using one of the following methods:

**Method A: Add the Build Directory to the System Path (*Recommended for Development*)**  
During active development of the C library, you might need to recompile the DLL frequently. Copying the file manually after every compilation is tedious and error-prone.

1. Add the absolute path of your local `mkl_delphi\build\` directory and the Intel MKL `lib` directory (e.g.: `C:\Program Files (x86)\Intel\oneAPI\mkl\2026.0\lib`) directly to your Windows system's PATH environment variable following the next steps for each directory:

* Press `Win + S`, type **"env"**, and select **Edit the system environment variables**.

* In the System Properties window, click on the **Environment Variables...** button.

* Under **System variables** (bottom list), select the variable named **Path** and click **Edit...**.

* Click **New** on the right side and type the absolute path to the directory.

* Click **OK** to close each of the three setup windows

**Method B: Place the DLL in the Executable Folder (*Recommended for Distribution*)**  
If you are packaging, deploying, or sharing your compiled Delphi application:

1. Locate your Delphi project's output directory (usually named `Win64\Debug` or `Win64\Release` inside your project's folder structure).

2. Copy `mkl_delphi.dll` from `mkl_delphi\build\` and paste it directly into that folder, alongside your compiled `.exe` file.

3. You must also include any required Intel MKL redistributable DLLs in this same folder.

### 2. Integrating the Wrapper in RAD Studio / Delphi
To use the library functions natively inside your Delphi Pascal source code, follow these steps:

1. Open your Delphi project in RAD Studio.

2. Go to the top menu and select **Project > Options...**.

3. In the left panel, navigate to **Building > Delphi Compiler**.

4. In the main area, click the **Search Path** field.

5. Click on the ellipsis `...` button and add the absolute path to the `interface\` folder inside your repository (e.g.: `C:\Projects\mkl_delphi\interface`).

6. Click **OK** and then **Save**.

**Example Usage:**

```
uses MKL;

// Example: Multiply matrices A and B into C using Intel MKL's highly optimized DGEMM
// Operation: C := alpha*op(A)*op(B) + beta*C
cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, 
            M, N, K, 
            1.0, @MatrixA[0], K, 
            @MatrixB[0], N, 
            0.0, @MatrixC[0], N);
```

## Academic Citation

If you use this software in your research, please cite it using the metadata provided in the `CITATION.cff` file located in the root of this repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.