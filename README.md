<p align="center">
<img src="https://img.shields.io/badge/Status | Stable-000000?logo=github&logoColor=white&style=for-the-badge&color=0D1116" alt="Status"height="25"> &nbsp; <img src="https://img.shields.io/badge/Clones | 489 (14 last days)-%23121011.svg?logo=github&logoColor=white&style=for-the-badge&color=0D1116" alt="Total clones"height="25">
</p>

<div align="center">
<img src="assets/ruvomain.png" width="400">
<br>
<strong>Universal Protocol with Pure Bash</strong><br>
<strong>Debloater and apk Installer 
  with system management for</strong><br>
<strong>All Android devices.</strong>
</div>

&nbsp;
<p align="center">
<img src="https://img.shields.io/badge/| Bash-4EAA25?logo=gnubash&logoColor=4EAA25&style=for-the-badge&color=0D1116"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| JSON-000?logo=json&logoColor=fff&style=for-the-badge&color=0D1116"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| ADB-3DDC84?logo=android&logoColor=3DDC84&style=for-the-badge&color=0D1116"height="25">
<img src="https://img.shields.io/badge/| Linux-yellow?&logo=linux&logoColor=yellow&style=for-the-badge&color=0D1116"height="25"> &nbsp; 
<img src="https://img.shields.io/badge/| Termux-000000?logo=iterm2&logoColor=fff&style=for-the-badge&color=0D1116"height="25" > &nbsp; 
<img src="https://img.shields.io/badge/| MacOS-magenta?&logo=Apple&logoColor=magenta&style=for-the-badge&color=0D1116"height="25" >
<img src="https://img.shields.io/badge/| Android Debloater and Installer-3DDC88?logo=android&logoColor=3DDC88&style=for-the-badge&color=0D1116"height="25">  &nbsp;
<img src="https://img.shields.io/badge/| S24+ Debloat-003087?logo=samsung&logoColor=003087&style=for-the-badge&color=0D1116"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| OneUI 8.5-FFC517?logo=samsung&logoColor=003087&style=for-the-badge&color=0D1116"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| Exynos Optimized-764ABC?logo=samsung&logoColor=003087&style=for-the-badge&color=0D1116" alt="Device"height="25"> 
<img src="https://img.shields.io/badge/No Root-FE7A16?&style=for-the-badge&color=0D1116"height="25"> &nbsp;
<img src="https://img.shields.io/badge/Thermal Optimized-FFB3C7?&style=for-the-badge&color=0D1116"height="25"> &nbsp;
<img src="https://img.shields.io/badge/Privacy Focused-%23FF0000.svg?&style=for-the-badge&color=0D1116"height="25">
<img src="https://img.shields.io/badge/| License GPLv3-black?logo=conventionalcommits&logoColor=f5f5f5&style=for-the-badge&color=0D1116" alt="License"height="25">
</p>

The **Ruvomain-pbd** script is a tool to surgically remove unwanted apps from Samsung and other phones without needing root access. It’s designed to be safe, clean, and keep your device integrity intact.
It's a zero-dependency, professional-grade infrastructure for system optimization. Designed for those who demand total sovereignty over their hardware, this protocol replaces bloated middleware (like Shizuku or Canta) with a 100% native Bash execution model.
**It 100% compatible with Canta .json restoration list files.**

**You can also install your own apk via ADB with ***ruvomain-installer*** script.**

*I'm not imposing anything on you: I provide infrastructure, you bring your data, and you execute code that you can read.*

---
**The Ruvomain Workflow**
1. **Setup :** Clone the repo.

2. **Clean :**
Run `./ruvomain-pdb/ruvomain.sh` (Pure Bash Debloater) to purge bloatware defined in `Configs/imports/*.json` or `/Configs/S24+/*.json`. (script detect and autoinstall android-tools)

*You can import your Canta restauration file.*

4. **Deploy :**
Run`./ruvomain-installer/installer.sh` to push your curated apps from `./Apps/`. (script detect and autoinstall android-tools) 

6. **Integrity :**
Your device is now Ruvomain-Compliant.

## 🚀 Ready to deploy?

**For Ruvomain-pbd script** (Pure Bash Debloater):

On Linux:
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol
# Place your personal or Canta JSON lists in ./Configs/Imports
cd ./Ruvomain-Protocol/ruvomain-pbd
chmod +x ruvomain.sh & ./ruvomain.sh
```
For Termux, MacOS read the **[Debloater Quick Start Guide](Docs/Quick-Start-Guide.md)**,

**(NEW)** **For ruvomain-installer script**(Pure Bash Installer):

On Linux:
```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol
# Place your personal apk files in ./ruvomain-installer/Apps
cd ./Ruvomain-Protocol/ruvomain-installer
chmod +x ruvomain-installer.sh & ./ruvomain-installer.sh
```
For Termux, MacOS read the **[Installer Quick Start Guide](Docs/Installer-Quick-Start.md)**,

For started in minutes

---
### Table of Contents

[Dictionnary: Technical Context](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#dictionnary-technical-context) 

[All Documentation](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#documentation)

[Features](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#features)

[Technical Architecture](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#-technical-architecture) 

[Comparaison Matrix](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-comparison-matrix) 

[Proof of Concept](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/README.md#-proof-screenshot)

[Why JSON and Pure Bash?](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/Why-JSON-Parsing-Pure-Bash-guarantee-privacy.md#why-json-parsing--pure-bash-guarantee-privacy) 

[Credits](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/README.md#-credits)

[Disclaimer](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-disclaimer)

---
## Features: 
"Surgical Minimalism" is the art of achieving maximum efficiency through the smallest possible codebase. By eliminating external dependencies, we reduce the system's attack surface and ensure absolute transparency.

**Interoperability:** 100% compatible with **Canta** .json restoration lists.

**Zero-Dependency:** No Java, no **Zero-Dependency:** No Java, no middleware, no pre-compiled binaries. Just pure shell.

**Auditable:** Every line of code is human-readable. You own the process from end to end.

**Autonomous:** The protocol executes, performs the surgical strike, and terminates. No resident services (daemons) remain in the background.

**Automated:**
>Automatic installation of ADB for Debian, Arch, and Fedora-based distributions, as well as for Termux 
>
>Select the list to apply (e.g., ruvomain_tier1_stable or your own file), and Ruvomain takes care of the debloating for you.

**APK Installation via ADB:**
With ruvomain-installer script you can install your own multiple apk files via ADB. Just place your apk in ./Apps folder and script run installation for you.

---
### 📸 Proof Screenshot
| Updates | Low Comsumption |
| :---: | :---: |
| <img src="assets/update.jpg" width="200"> | <img src="assets/battery2.jpg" width="200"> |
| You can make official updates without problem | Low energy consumption in standby mode |

| Resource Management | CPU & Thermal Management |
| :---: | :---: |
| <img src="assets/ram1.jpg" width="200"> | <img src="assets/thermalg2.jpg" width="200"> |
| Optimized background processes in RAM. | The CPU is not overloaded, which limits heat generation and allows for a deep sleep state and 10h+ SOT. |

---
## 🚀 Technical Architecture

The core of **Ruvomain-PBD** is `json-walk`, an event-driven (SAX-style) parser written in pure Bash. It processes your configurations natively, ensuring compatibility across Linux, Termux, and Android without requiring external binaries like `jq`.

---
## ⚖️ Comparison Matrix

| Feature | Standard Approach (Canta/Shizuku)| **Ruvomain-PBD** |
| :--- | :--- | :--- |
| **Dependencies** | Java, Shizuku, Canta, `jq` | **None (Zero-Dependency)** |
| **Memory Footprint** | Permanent (Active service) | **None (One-time execution)** |
| **Auditability** | Limited (Black-box) | **Total (Native Bash)** |
| **Complexity** | High(Multi-layered) | **Minimalist (Surgical)** |

---
## Contributing
<details>
<summary><b>You have a specific device? Create your JSON profile </b></summary>

Fork this repo, place it in `/Configs/Imports`, and submit a Pull Request. Your configuration will then be available to the entire community.
Create a JSON file [following the protocol schema](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/structure-example.json). More information [here](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/README.md).*
</details>

<details>
<summary><b>Need help with your first contribution ? </b></summary>
  
Need help with your first contribution? [Consult this guide](https://github.com/firstcontributions/first-contributions) to learn the basics of pull requests.
</details>

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

- [Package List](Docs/Tiers-list.md) (S24+)
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
### 👥 Credits

*   "100% Bash Parser for JSON" - thanks to [smmoosavi](https://github.com/smmoosavi/json-walk) for json-walk.
*   Thanks to [Dyokism](https://github.com/dyokism) for code contribution.
*   **Validation:** Rigorous cross-verification with [Willie_169](https://github.com/Willie169) and OneUI 8.0 JSON config file.
*   **Community Testing:** Special thanks to @ric69 for empirical field-testing of Tier 1 stability.

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

---
*My other project on github for [Google Pixel6, LineageOS Vanilla 23.2](https://github.com/Ruvyrom/Ruvyrom/tree/main)*



