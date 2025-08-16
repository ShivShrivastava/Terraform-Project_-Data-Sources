Perfect bhai! Tere Terraform code ke base par maine ek **professional-level `README.md`** bana diya hai — jo tu seedha apne GitHub repo mein daal sakta hai. 👇

---

## ✅ `README.md` – Final Version

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

## 📜 Terraform Code Summary

### `main.tf`

```hcl
variable "prefix" {
  default = "shiv"
}

# Data sources
data "azurerm_resource_group" "shared-rg" {
  name = "shared-network-rg"
}

data "azurerm_virtual_network" "shared-vnet" {
  name                = "share-vnet"
  resource_group_name = data.azurerm_resource_group.shared-rg.name
}

data "azurerm_subnet" "shared-subnet" {
  name                 = "shared-subnet"
  resource_group_name  = data.azurerm_resource_group.shared-rg.name
  virtual_network_name = data.azurerm_virtual_network.shared-vnet.name
}

# New Resource Group (for VM)
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = data.azurerm_resource_group.shared-rg.location
}

# NIC using existing subnet
resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.azurerm_subnet.shared-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Linux Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vmshared"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1s"
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}
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

## 📤 Outputs (Optional)

You can add this to an `outputs.tf` file:

```hcl
output "vm_id" {
  value = azurerm_virtual_machine.vm.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}
```

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

Created by [Shiv SHrivastava](https://github.com/ShivShrivastava)

---

## ⭐ Like This Repo?

Give it a ⭐ on GitHub if you found it useful!

````

---

### ✅ Now What To Do:
1. Paste this `README.md` file in your repo root.
2. Commit & push to GitHub:
   ```bash
   git add README.md
   git commit -m "Added project README"
   git push
````

---


