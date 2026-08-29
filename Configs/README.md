### JSON files importation

You have a specific device? Create your JSON list or Canta restoration JSON list, fork this repo, place it in `/Configs`, and submit a Pull Request. Your configuration will then be available to the entire community."

- You **must** create your JSON file list with **THIS STRUCTURE**: **[structure-example.json](https://github.com/Ruvyrom/Ruvomain-Protocol/blob/main/Docs/structure-example.json)**

For using your liste with Ruvomain-pbd script:
- **Copy** your personal or Canta .json restoration files in `./Configs/Imports` folder

- **Execute** script and select option 4 when prompted

- **Select** your file, confirm and it applying

**Feel free to share your files to help grow the community!**

**Please ensure:**

- The JSON syntax is [valid](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Configs/Imports/structure-example.json).

- You have tested the debloat list on your own device.

- You keep the minimalist philosophy of the project.

- Contribute with Pull Request.

**Naming Convention for Imports:**
`[Philosophy]-[DeviceName]-[OSVersion].json`
*Example:*

*Baremetal-Pixel6-LOS232.json*

*Degoogle-OP15-OxyOS15.json*

Need help with your first contribution? [Consult this guide](https://github.com/firstcontributions/first-contributions) to learn the basics of pull requests.


### Protocol Hierarchy
The protocol is modular, allowing users to choose their level of optimization. *Tierslists are provided as standardized defaults, but the architecture is designed for you to edit `tier*.json` files to fit your specific operational requirements.*

You can modify .json files if you want keep a fonctionality in /Configs/S24+

| Tier | Strategy| Recommended For |
|:---|:---|:---|
| **Tier 1 (Stable/Conservative)** | Redundancy & Telemetry | All users seeking immediate gains. |
| **Tier 2 (Advanced/Balanced)** | AI Telemetry & Cloud Bloat | Users prioritizing privacy & efficiency. |
| **Tier 3 (Surgical/Extreme)** | Ghost Mode (System Core) | Advanced users building a bare-metal experience. |

The protocol keep `Samsung Camera` and `gallery`, `Dolby Atmos`, `Samsung Screenshot`, `OneUI launcher`.
For privacy, you can block internet connexion (with firewall) for these apps without problem.

**For view packages list and descriptions see the /docs/[package-list.md](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/package-list.md)**

**⚠️ Before use Tier3, you must read /docs/[REMPLACEMENT.md](https://github.com/Ruvyrom/Ruvomain-Protocole/blob/main/Docs/REMPLACEMENT.md)**
