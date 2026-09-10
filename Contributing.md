# Contributing to URAAM

Thanks for your interest in improving URAAM!

**You have a specific device?**

- Create your own JSON list manually or with Backup or Canta/UAD list and place it in `./Configs/backup-restore`, and submit a Pull Request.

OR

- Create a json file with Canta, rename it follow the "Naming Convention for Imports" below, place it in `./Configs/debloat` and submit a Pull Request.

Your configuration will then be available to the entire community.

**Create a JSON file [following the protocol schema](/Docs/structure-example.json).

Please ensure:
- The JSON syntax is valid.
- You have tested the debloat list on your own device.
- You keep the minimalist philosophy of the project.

**Naming Convention for Imports:**
`[Philosophy]-[DeviceName]-[OSVersion].json`

*Example:*

*Baremetal-Pixel6-LOS232.json*

*Degoogle-OP15-OxyOS*.json*

# Note for skeptics:
This structure is designed to be auditable, not just automated. Everything here is hand-coded to ensure 0-day debloat safety.
