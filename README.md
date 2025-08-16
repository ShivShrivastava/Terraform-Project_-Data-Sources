# Terraform-Project_-Data-Sources

```markdown
# 🚀 Terraform: Create Azure VM in Existing VNet & Subnet (Using Data Sources)

This project demonstrates how to use **Terraform Data Sources** to reference an **existing Azure Resource Group, Virtual Network, and Subnet**, and create a new **Linux Virtual Machine (Ubuntu)** in that subnet.

---

## 📁 Project Overview

- ✅ Uses Terraform **data sources** to fetch:
  - Existing Resource Group
  - Existing Virtual Network (VNet)
  - Existing Subnet
- ✅ Creates:
  - A new Resource Group
  - A Network Interface (NIC)
  - A Linux Virtual Machine (Ubuntu 22.04 LTS)

---

## 🧠 What You'll Learn

- How to reference **existing Azure infrastructure** using `data` blocks
- How to create dependent resources (VM, NIC) dynamically
- How to structure basic Terraform deployments

---

## 🔧 Prerequisites

- Azure Subscription (Free or Paid)
- Existing resources in Azure:
  - Resource Group: `shared-network-rg`
  - VNet: `share-vnet`
  - Subnet: `shared-subnet`
- Terraform installed (`>= 1.0`)
- Azure CLI authenticated (`az login`)

---

## 📦 Folder Layout

```

.
├── main.tf
├── variables.tf
├── outputs.tf (optional)
├── README.md
└── .gitignore

````

---

## 🚀 How to Use This

1. **Clone the repo**

   ```bash
   git clone https://github.com/your-username/terraform-vm-existing-vnet.git
   cd terraform-vm-existing-vnet
   ```

2. **Login to Azure**

   ```bash
   az login
   ```

3. **Initialize Terraform**

   ```bash
   terraform init
   ```

4. **Preview changes**

   ```bash
   terraform plan
   ```

5. **Apply configuration**

   ```bash
   terraform apply
   ```

---

## 🔐 Security Note

> The VM is using a **hardcoded password** (`Password1234!`) — for production use, store secrets in **Key Vault**, use **SSH keys**, or use `TF_VAR_` environment variables.

---


## 📌 Best Practices Followed

* Data sources for reusing infra
* Variable usage with prefixes
* Proper resource naming conventions
* Tags for environment classification

---

## 📄 License

MIT

---

## ✍️ Author

Created by [Shiv Shrivastava](https://github.com/ShivShrivastava)

---

## ⭐ Like This Repo?

Give it a ⭐ on GitHub if you found it useful!

````
