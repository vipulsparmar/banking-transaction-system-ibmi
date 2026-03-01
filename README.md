# 🏦 Multi-Tiered Banking Transaction System (IBM i)

A robust financial transaction processing engine developed on **IBM i (AS/400)**, featuring real-time account management, subfile-based interactive dashboards, and automated batch processing.

## 🚀 Key Features

- **RPGLE Transaction Engine**: Processes Deposits and Withdrawals with strict **Record-Locking** to ensure data integrity during simultaneous updates.
- **Subfile Dashboard**: An interactive, real-time dashboard built using **SDA** (Screen Design Aid) to query account balances and transaction history.
- **CLLE Batch Control**: Automates library list management (`ADDLIBLE`) and environment setup for seamless module execution.
- **DB2/400 Database**: Relational schema designed using **DDS** (Data Description Specifications) for optimized storage and fast retrieval.

## 🛠️ Tech Stack

- **Languages**: RPGLE (Free-form), CLLE (Control Language), DDS (Data Description).
- **Tools**: SEU/RDP/VS Code, SDA (Screen Design Aid), IBM i Operating System.
- **Database**: DB2 for i (Physical Files).

## 📁 Repository Structure

```text
├── QDDSSRC/
│   ├── ACCOUNTS.pf    # Account Master physical file
│   ├── TRANSACT.pf    # Transaction History physical file
│   └── ACCT_DSPF.dspf # Subfile display file
├── QRPGLESRC/
│   └── TXN_ENGINE.rpgle # Main transaction logic
├── QCLSRC/
│   └── INIT_PGM.clle   # Environment setup and driver
└── README.md
```

## 🏗️ How to Deploy

1. **Create Source Files**: If not already present, create `QDDSSRC`, `QRPGLESRC`, and `QCLSRC` in your development library.
2. **Compile DB**: Run `CRTPF` on the physical file members in `QDDSSRC`.
3. **Compile Display**: Run `CRTDSPF` on `ACCT_DSPF`.
4. **Compile Logic**: Run `CRTBNDRPG` on `TXN_ENGINE`.
5. **Compile Driver**: Run `CRTBNDCL` on `INIT_PGM`.
6. **Execute**: `CALL PGM(INIT_PGM)` to launch the dashboard.

---
*Developed as part of my IBM i & Data Projects Portfolio.*
