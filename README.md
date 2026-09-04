<p align="center">
<img src="https://img.shields.io/badge/Status | Stable-000000?logo=github&logoColor=white&style=for-the-badge&color=151B22" alt="Status"height="25"> &nbsp; <img src="https://img.shields.io/badge/Clones | 1359 (14 last days)-%23121011.svg?logo=github&logoColor=white&style=for-the-badge&color=151B22" alt="Total clones"height="25">
</p>

<div align="center"; style="background-color: #151B22; display: inline-block">
<img src="assets/ruvomain.png" width="400">
<br>
<strong>Universal Ruvomain ADB Apps-Manager [URAAM]</strong>
<br><strong>(Debloat, Restore, Backup list [json files] and APK Installer)</strong></br>
<strong>for ALL Android devices.</strong>
</div>

&nbsp;
<p align="center">
<img src="https://img.shields.io/badge/| Bash-4EAA25?logo=gnubash&logoColor=4EAA25&style=for-the-badge&color=151B22"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| JSON-000?logo=json&logoColor=fff&style=for-the-badge&color=151B22"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| ADB-3DDC84?logo=android&logoColor=3DDC84&style=for-the-badge&color=151B22"height="25">
<img src="https://img.shields.io/badge/| Linux-yellow?&logo=linux&logoColor=yellow&style=for-the-badge&color=151B22"height="25"> &nbsp; 
<img src="https://img.shields.io/badge/| Termux-000000?logo=iterm2&logoColor=fff&style=for-the-badge&color=151B22"height="25" > &nbsp; 
<img src="https://img.shields.io/badge/| MacOS-magenta?&logo=Apple&logoColor=magenta&style=for-the-badge&color=151B22"height="25" >
<img src="https://custom-icon-badges.demolab.com/badge/ | WSL-0078D6?logo=windows11&logoColor=blue&style=for-the-badge&color=151B22"height="25">  &nbsp;
<img src="https://img.shields.io/badge/| Android-3DDC88?logo=android&logoColor=3DDC84&style=for-the-badge&color=151B22"height="25">  &nbsp;
<img src="https://img.shields.io/badge/| Debloater-003087?logo=android&logoColor=3DDC84&style=for-the-badge&color=151B22"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| Restore-FFC517?logo=android&logoColor=3DDC84&style=for-the-badge&color=151B22"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| App Manager-764ABC?logo=android&logoColor=3DDC84&style=for-the-badge&color=151B22" alt="Device"height="25"> &nbsp;
<img src="https://img.shields.io/badge/No Root-FE7A16?&style=for-the-badge&color=151B22"height="25"> &nbsp;
<img src="https://img.shields.io/badge/Canta compatible-FFB3C7?&style=for-the-badge&color=151B22"height="25"> &nbsp;
<img src="https://img.shields.io/badge/Privacy Focused-%23FF0000.svg?&style=for-the-badge&color=151B22"height="25"> &nbsp;
<img src="https://img.shields.io/badge/| License GPLv3-black?logo=conventionalcommits&logoColor=f5f5f5&style=for-the-badge&color=151B22" alt="License"height="25">
</p>

<div align="center"; style="display: inline-block">
The UNIVERSAL RUVOMAIN ADB APPS-MANAGER (URAAM) scripts is a tool suite to surgically remove unwanted apps, restore uninstalled apps, backup uninstalled apps in json file and install your own apk. Compatible with all Android phones without needing root access via ADB. It’s designed to be safe, clean, and keep your device integrity intact.
Professional-grade infrastructure for system optimization. Designed for those who demand total sovereignty over their hardware, this protocol replaces bloated middleware (like Shizuku or Canta) with a native Bash execution model and jq.
**It is 100% compatible with Canta .json restoration list files. (you can debloat/restore your Canta list without Shizuku/Canta)**

<br>*I'm not imposing anything on you: I provide infrastructure, you bring your data, and you execute code that you can read.*</br></div>

---
> **🚀 Latest Updates:**
> - **2026-03-09:** Added 7 new curated JSON configurations in [/Configs](https://github.com/Ruvyrom/Ruvomain-Protocol/tree/main/Configs) (Safelists for Samsung Galaxy S24/S25 One UI, Xiaomi HyperOS, Vivo, TCL Android TV and carrier bloatware).
> - **2026-02-28:** Released unified Dashboard TUI + 4 modular core BASH engines for URAAM.
---
## 🚀 Ready to deploy?

**UNIVERSAL RUVOMAIN ADB APPS-MANAGER (URAAM):**

<details>
<summary>Enable USB Debugging on your device:</summary>

Settings > About phone > Tap "Build Number" 7 times

Settings > Developer Options > Enable "USB Debugging"

Connect your device to your PC via USB
</details>

On Linux:

```bash
git clone https://github.com/Ruvyrom/Ruvomain-Protocol
```
- For Ruvomain-debloat, place your personal or Canta JSON lists in ./Configs
- For Ruvomain-installer, place your `APK` files in ./ruvomain-installer/Apps 
- For Ruvomain-restore, use your backup created with ruvomain-backup.sh or place your own backup .json file or Canta .json file list in ./ruvomain-backup/backups
- Ruvomain-backup places your backup .json file in /ruvomain-backup/backups

**Execute Universal Ruvomain ADB Apps-Manager (URAAM):**
```bash
make -C ./Ruvomain-Protocol
```

OR

```bash
cd ./Ruvomain-Protocol
chmod +x dashboard.sh && ./dashboard.sh
```
</details>

For more detailled instructions for Linux, Termux, MacOS & WSL, read the **[URAAM - Quick Start Guide](Docs/Quick-Start-Guide.md)**,

For execute other make command use help in Makefile:
```bash
cd ./Ruvomain-Protocol
make help
```
---
### Table of Contents

[Contributing](https://github.com/Ruvyrom/Ruvomain-Protocol/tree/main#-contributing)

[Dictionary: Technical Context](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#dictionnary-technical-context) 

[All Documentation](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/README.md#-documentation)

[Features](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#features)

[Technical Architecture](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#-technical-architecture) 

[Comparaison Matrix](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-comparison-matrix) 

[Proof of Concept](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/README.md#-proof-screenshot)

[Credits](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/README.md#-credits)

[Disclaimer](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/README.md#%EF%B8%8F-disclaimer)

---
## ⚙️ Features: 
"Surgical Minimalism" is the art of achieving maximum efficiency through the smallest possible codebase. By eliminating external dependencies, we reduce the system's attack surface and ensure absolute transparency.

<details>
<summary><b>Interoperability:</b></summary>

>100% compatible with **Canta** .json restoration lists. (ruvomain-debloat, ruvomain-restore)
</details>

<details>
<summary><b>Auditable:</b></summary>

>Every line of code is human-readable. You own the process from end to end.
</details>

<details>
<summary><b>Autonomous:</b></summary>

>The protocol executes, performs the surgical strike, and terminates. No resident services (daemons) remain in the background.
</details>

<details>
<summary><b>APK Installation via ADB:</b></summary>

>With ruvomain-installer script you can install your own multiple apk files via ADB. Just place your apk in ./Apps folder and script run installation for you.
</details>

<details>
<summary><b>Backup to .json list</b></summary>

>With ruvomain-backup, backup your uninstalled apps list to .json file for restore later.
</details>

<details>
<summary><b>Restore uninstalled apps via ADB</b></summary>

>With ruvomain-restore, reinstall your uninstalled apps via adb with .json backup files in ./ruvomain-backup/backups
</details>

<details>
<summary><b>Automated:</b></summary>

>Automatic installation of ADB and jq for Debian, Arch, and Fedora-based distributions, as well as for Termux 

>Select the list to apply (e.g., Tier1_S24plus-OneUI85.json or your own file), and Ruvomain takes care of the debloating/restoring for you.
</details>

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
## ⚖️ Comparison Matrix

| Feature | Standard Approach (Canta/Shizuku)| **Ruvomain URAAM** |
| :--- | :--- | :--- |
| **Dependencies** | Java, Shizuku, Canta | **jq** |
| **Memory Footprint** | Permanent (Active service) | **None (One-time execution)** |
| **Auditability** | Limited (Black-box) | **Total (Native Bash)** |
| **Complexity** | High(Multi-layered) | **Minimalist (Surgical)** |

---
## 👥 Contributing

**You have a specific device? Create your JSON file list or import Canta backup list file!**

Fork this repo, place it in `/Configs`, and submit a Pull Request. Your configuration will then be available to the entire community.
For create your JSON list file or import Canta backup [following the contributing guide](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/Configs/README.md#contributing---json-files-importation).

>**Need help with your first contribution?** *[Consult this guide](https://github.com/firstcontributions/first-contributions) to learn the basics of pull requests.*

---
## 📖 Documentation
To gain a deeper understanding of the technical and operational aspects of the protocol, please refer to the following files located in the `/Docs` directory:

<details>
<summary><b>Clic to view documentation</b></summary>

- [Protocol Hierarchy](/Docs/Protocol-Hierarchy.md) (3 tiers packages list exemple for S24+)

>An overview of the protocol's global architecture.

- [JSON files importation](https://github.com/Ruvyrom/Ruvomain-Protocol/tree/main/Configs#json-files-importation)

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
</details>

---
### 👥 Credits

*   "100% Bash Parser for JSON" - thanks to [smmoosavi](https://github.com/smmoosavi/json-walk) for json-walk.
*   Thanks to [Dyokism](https://github.com/dyokism) for code contribution.
*   **Validation:** Rigorous cross-verification with [Willie_169](https://github.com/Willie169) and OneUI 8.0 JSON config file.
*   **Community Testing:** Special thanks to @ric69 for empirical field-testing of Tier 1 stability.

---
### Dictionary: Technical Context
<details>
<summary><b>⚙️ What is ADB? (Forbeginners)</b></summary>

ADB (Android Debug Bridge) is the core command-line utility that creates a bridge between your computer and your phone’s operating system.

For the Universal Ruvomain ADB Apps-Manager (URAAM), ADB is our primary "privileged channel." It allows us to execute shell commands and surgically modify system packages—all <b>without root access</b>. This is critical for our approach: it lets us strip out bloatware and reclaim device sovereignty while keeping the system’s native security integrity and Samsung Knox completely intact.
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

Git is our "version control" system. Think of it as a time machine for the RuvomainProtocol. Every change, improvement, or optimization we make is recorded in the project's history. This allows us to track exactly howthe protocol evolves, roll back to previous versions if needed, and ensures that the project remains a transparent, collaborative, and living system—not just a static file.
</details>

---
## ✅ Current Status:
Stable environment. No critical system crashes or UI stutters detected in daily driving.

## ⚠️ Disclaimer
*I am not responsible for any issues resulting from system modifications. Always perform a data backup before deployment.*

---
*My other project on github for [Google Pixel6, LineageOS Vanilla 23.2](https://github.com/Ruvyrom/Ruvyrom/tree/main)*



