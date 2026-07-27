# Ruvomain Protocol v3
<p align="center">
<img src="https://img.shields.io/badge/Status | Stable-%23121011.svg?logo=github&logoColor=white&style=flat-square" alt="Status"> &nbsp; <img src="https://img.shields.io/badge/Clones | 2028 (14 last days)-%23121011.svg?logo=github&logoColor=white&style=flat-square" alt="Total clones">
</p>

![](assets/ruvomain.jpg)
<p align="center"> Universal Protocol with Pure Bash Debloater and system management for Samsung S24+ & other Android devices.</p>

---
<p align="center">
<img src="https://img.shields.io/badge/| Bash-4EAA25?logo=gnubash&logoColor=fff&style=flat-square">
<!-- <img src="https://img.shields.io/badge/Bash-JSON-black?logo=gnubash&logoColor=f5f5f5"> --> &nbsp; <img src="https://img.shields.io/badge/| JSON-000?logo=json&logoColor=fff&style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/| ADB-3DDC84?logo=android&logoColor=white&style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/| Termux-000000?logo=iterm2&logoColor=fff&style=flat-square" > <!-- <img src="https://img.shields.io/badge/ADB-TERMUX-black?logo=android&logoColor=f5f5f5"> -->
</p>
<p align="center">
<img src="https://img.shields.io/badge/| S24+ Debloat-003087?logo=samsung&style=flat-square" > &nbsp; <img src="https://img.shields.io/badge/| OneUI 8.5-FFC517?logo=samsung&style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/| Exynos Optimized-764ABC?logo=samsung&style=flat-square" alt="Device"> &nbsp; <img src="https://img.shields.io/badge/| Android Debloat-3DDC84?logo=android&logoColor=white&style=flat-square">
</p>
<p align="center">
<img src="https://img.shields.io/badge/No Root-FE7A16?style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/Thermal Optimized-FFB3C7?style=flat-square"> &nbsp; <img src="https://img.shields.io/badge/Privacy Focused-%23FF0000.svg?style=flat-square">
</p>
<p align="center">
<img src="https://img.shields.io/badge/| License MIT-black?logo=conventionalcommits&logoColor=f5f5f5&style=flat-square" alt=License>
</p>

> This project is a tool to surgically remove unwanted apps from Samsung and other phones without needing root access. It’s designed to be safe, clean, and keep your device integrity intact.
>
> **Note:** This tool runs via the command line (terminal). It’s built for users who want deep control over their device. If you're looking for a "one-click" app with a standard interface, this might not be for you.

[Dictionnary: Technical Context](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#dictionnary-technical-context) 

After 16 years of messing around with Android modding, I finally got tired of re-running the same ADB commands every time Samsung pushes a security patch or I need to re-provisionmy environment.

I’ve started putting my **Ruvomain-PBD** is a zero-dependency, professional-grade infrastructure for system optimization. Designed for those who demand total sovereignty over their hardware, this protocol replaces bloated middleware (like Shizuku or Canta) with a 100% native Bash execution model.

<details>
<summary><b>You have a specific device? Create your JSON profile </b></summary>

Fork this repo, place it in `/Configs/Imports`, and submit a Pull Request. Your configuration will then be available to the entire community.
Create a JSON file [following the protocol schema](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/structure-example.json). More information [here](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md).*
</details>

<details>
<summary><b>Need help with your first contribution ? </b></summary>
  
Need help with your first contribution? [Consult this guide](https://github.com/firstcontributions/first-contributions) to learn the basics of pull requests.
</details>

***Note:***
>This project is maintained manually. I wrote these scripts because I was tired of the bloat on my S24+. No AI fluff, just pure Bash and system-level configuration for people who value their time and privacy.

---
### Table of Contents
[Documentation](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#documentation)

[Features](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#features)

[Technical Architecture](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#-technical-architecture) 

**[Quick Start](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#%EF%B8%8F-quick-start)**

[Comparaison Matrix](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-comparison-matrix) 

[Proof of Concept](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#-proof-of-concept)

[Why JSON and Pure Bash?](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/Why-JSON-Parsing-Pure-Bash-guarantee-privacy.md#why-json-parsing--pure-bash-guarantee-privacy) 

[Community and Credits](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-community--credits)

[Disclaimer](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-disclaimer)

[Hall of Fame](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#hall-of-fame)

---
Got questions? Reddit is the place to discuss builds.
>[r/Ruvomain](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)

---
## ⚙️ Quick Start
**Disconnect Samsung account before using tier 2 and 3 in script and for more privacy.**

### Ruvomain-PBD (Pure Bash Debloater)
Local, offline-capable usage.

Enable USB Debugging on your phone: 
>
>Settings > About Phone > Tap "Build Number" 7 times
>
>Settings > Developer Options > Enable "USB Debugging"
>
>Connect your phone to your PC via USB

### 🐧 For Linux users:
1. **Prerequisites:**
  
- `adb` (The script will attempt an android-tools auto-installation if missing).

2. **Deployment:**
- **Clone the repo:** `git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`

- **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal configuration file (for s24+ or other Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

- **Navigate:** `cd ./Ruvomain-Protocole/ruvomain-pdb/`

- **Execute:**
`chmod +x ruvomain.sh && ./ruvomain.sh`

### 📱 For Termux users
- **Grant Storage Access:** `termux-setup-storage` (Accept the permission prompt)

- **Deploy:** Follow the same steps as the [Linux](https://github.com/Ruvyrom/Ruvomain-Protocole/tree/main#-for-linux-users) deployment above.

### 🍎 For MacOS users:
1. Install [Homebrew](https://brew.sh/) if you haven't already.

2. **Install ADB:**
`brew install git android-platform-tools`

3. **Clone the protocol:**
`git clone https://github.com/Ruvyrom/Ruvomain-Protocole.git`
`cd Ruvomain-Protocole/ruvomain-pdb`

4. **Verify device connection:**
`adb devices`
*(If "unauthorized", check your phonescreen and tap "Always allow")*

5. **(Optional) [import](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md) your personnal configuration file (for s24+ or other Android devices) or Modify** ruvomain_tier*_stable.json in `/Configs/S24+`

6. **Execute:**
`cd ./Ruvomain-Protocole/ADB-Termux/devices/S24+`
`./ruvomain.sh`

5.  **Finalize:** Reboot the device.

---
## Features: 
"Surgical Minimalism" is the art of achieving maximum efficiency through the smallest possible codebase. By eliminating external dependencies, we reduce the system's attack surface and ensure absolute transparency.

**Zero-Dependency:** No Java, no **Zero-Dependency:** No Java, no middleware, no pre-compiled binaries. Just pure shell.

**Auditable:** Every line of code is human-readable. You own the process from end to end.

**Autonomous:** The protocol executes, performs the surgical strike, and terminates. No resident services (daemons) remain in the background.

**Automated:**
>Automatic installation of ADB for Debian, Arch, and Fedora-based distributions, as well as for Termux 
>
>Select the list to apply (e.g., ruvomain_tier1_stable or your own file), and Ruvomain takes care of the debloating for you.

---
## ⚖️ Comparison Matrix

| Feature | Standard Approach (Canta/Shizuku)| **Ruvomain-PBD** |
| :--- | :--- | :--- |
| **Dependencies** | Java, Shizuku, Canta, `jq` | **None (Zero-Dependency)** |
| **Memory Footprint** | Permanent (Active service) | **None (One-time execution)** |
| **Auditability** | Limited (Black-box) | **Total (Native Bash)** |
| **Complexity** | High(Multi-layered) | **Minimalist (Surgical)** |

---
## 🚀 Technical Architecture

The core of **Ruvomain-PBD** is `json-walk`, an event-driven (SAX-style) parser written in pure Bash. It processes your configurations natively, ensuring compatibility across Linux, Termux, and Android without requiring external binaries like `jq`.

---
## Documentation
To gain a deeper understanding of the technical and operational aspects of the protocol, please refer to the following files located in the `/Docs` directory:

- [Protocol Hierarchy](/Docs/Protocol-Hierarchy.md) (3 tiers packages list exemple for S24+)
>An overview of the protocol's global architecture.

<!--- [Using the Makefile](/Docs/Using-the-Makefile.md)
>A comprehensive guide to the secure control interface.-->

- [JSON files importation](/Configs/Imports/README.md)
>How to import your personnal .json list files (for S24+ or other devices) for using with Ruvomain-pbd script.

- [Network & Resource Confinement](/Docs/Network-&-Resource-Confinement-Layers.md)
>Technical details on system hardening and resource management.

- [Package List](Docs/package-list.md) (S24+)
>A detailed list of components targeted by the protocol.

- [Replacement](/Docs/Remplacement.md)
>Documentation regarding software substitution processes and procedures.Users on different hardware or firmware versions should exercise caution and verify package dependencies before execution.

- [Interface Setup](/Docs/Interface-Setup.md)
>A guide to achieving an AOSP-like aestheticand maximum operational efficiency while retaining native Samsung system optimizations.

- [Monitoring Strategy](/Docs/Monitoring-Strategy.md)
>Methodologies for analyzing system behavior, battery drain, and network telemetry to maintain long-term stability.

- [Safety & Auditing](Docs/Safety-&-Auditing.md)
>Information regarding code transparency, audit processes, and system integrity maintenance.

---
Got questions? Reddit is the place to discuss builds.
>[r/Ruvomain](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)

---
### 👥 Community & Credits
For support, discussions, and the latest news on the Ruvomain Protocol, join our Community:
>[Reddit](https://www.reddit.com/r/Ruvomain/s/9HlpNjl2M7)
>[Telegram Channel](https://t.me/ruvomain)

*   "100% Bash Parser for JSON" - thanks to [smmoosavi](https://github.com/smmoosavi/json-walk) for json-walk.
*   **Validation:** Rigorous cross-verification with [Willie_169](https://github.com/Willie169).
*   **Architecture:** Formal acknowledgment of the Canta workflow by [Samolego](https://samolego.github.io/Canta/).
*   **Community Testing:** Special thanks to @ric69 for empirical field-testing of Tier 1 stability.

---
### 📸 Proof of Concept
<img src="assets/accu-93.jpg" width="400"><img src="assets/battery2.jpg" width="400"><img src="assets/thermalg2.jpg" width="400"> <img src="assets/thermalg-cpu.jpg" width="400"> <img src="assets/thermalg-temp.jpg" width="400"> <img src="assets/ram1.jpg" width="400">

---
### Dictionnary: Technical Context
<details>
<summary><b>⚙️ What is ADB? (Forbeginners)</b></summary>

ADB (Android Debug Bridge) is the core command-line utility that creates a bridge between your computer and your phone’s operating system.

For the Ruvomain Protocol, ADB is our primary "privileged channel." It allows us to execute shell commands and surgically modify system packages—all <b>without root access</b>. This is critical for ourapproach: it lets us strip out bloatware and reclaim device sovereignty while keeping the system’s native security integrity and Samsung Knox completely intact.
</details>

<details>
<summary><b>🐚 What is Bash? (Why we use it)</b></summary>

Bash is the scripting language that powers the Ruvomain Protocol. We chose it for one reason: <b>transparency</b>. Unlike closed-source tools that hide their logic in a "blackbox," our Bash scripts are written in plain, readable text. This means you can personally audit, verify, and understand every single command before it touches your device. It is the foundation of a truly trust-based and auditable system.
</details>

<details>
<summary><b>📄 What is JSON? (Our configuration layer)</b></summary>

JSON acts as our "configuration layer." It is a simple, human-readable format that holds the data for the protocol, essentially acting as a map that tells the scripts exactly which packages to target. By separating our data (the JSON files) from our logic (the Bashscripts), we keep the protocol modular and incredibly easy to customize. You don't need to be a coder to manage these lists; you just need to edit the map.
</details>

<details>
<summary><b>🔄 What is Git? (Why it matters)</b></summary>

Git is our "version control" system. Think of it as a time machine for the RuvomainProtocol. Every change, improvement, or optimization we make is recorded in the project's history. This allows us to track exactly howthe protocol evolves, roll back to previous versions if needed, and ensures that the project remains a transparent, collaborative, and living system—notjust a static file.
</details>

---
## ✅ Current Status:
Stable environment. No critical system crashes or UI stutters detected in daily driving.

## ⚠️ Disclaimer
*I am not responsible for any issues resulting from system modifications. Always perform a data backup before deployment.*

### 🏆 Hall of Fame
* **Institutional Censorship:** Term "Ruvomain" filtered on XDA; posting rights revoked on r/androidroot.
* **Diagnosis:** The protocol's surgical efficiency threatens the root-dependency paradigm. We don't ask for permission to optimize; we just do it.

---
*My other project on github for [Google Pixel6, LineageOS Vanilla 23.2](https://github.com/Ruvyrom/Ruvyrom/tree/main)*
