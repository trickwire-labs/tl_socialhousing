![Image](https://github.com/user-attachments/assets/b8393824-d5f2-41f9-a40c-9aa41108dc90)

# 🏘️ Social Housing for FiveM 🏘️

An ESX-only barebones "social housing" ("case popolari", in Italian) resource created mainly for italian crime-based RP servers. This was created by keeping in mind what most Italian RP servers want and need in a social housing script: a simple, free-to-select house with a stash and a wardrobe. No house sharing, garage, furniture, or other features, as players are pushed to purchase an actual home.

### [Showcase](https://youtu.be/zxKIHiRfcwk) ###

---

## 🌟 Features 🌟

### 🏠 **Features**
- **Interactions**: Every house has a stash, a wardrobe, and get-in/get-out points.
- **Private usage**: Players are hidden from other players while in their house.
- **Seller**: Players can visit a ped to choose a different house or purchase a key.

### 🛠️ **Configuration**
- **Data**: Every piece of data within the resource is fully configurable in the `config.lua` file. This includes distances, dimensions, houses, ipls, markers, and more.
- **Language support**: Languages included in a `locale.lua` file. Languages currently pre-defined: English and Italian, but you're free to add any other language.

### 💻 **Dev-friendly**
- **Debugging**: Extremely extensive, language-aware debugging for developers wanting to work with the resource.
- **Function subdivision**: Functions are extensively subdivided (maybe even too much), to (hopefully) improve code readability.

### 🔩 **Compatiblity**
- **Interaction methods**: Supports both ox_lib points (with textUI) and "third-eyeing" with ox_target.
- **Customization**: Customizable textUI and notification functions to allow quick n easy integration with any textUI or notification resource.
- **Supports ESX**: Currently only supports ESX, but PRs supporting any other framework are welcomed. This was meant as a quick project, as 99% of servers needing this type of resource run on ESX.

### 🔴 **Dependencies**
- **[ox_lib](https://github.com/overextended/ox_lib)**
- **[ox_inventory](https://github.com/overextended/ox_inventory)**
- **[es_extended](https://github.com/esx-framework)**

---

## 🚀 Installation 🚀

1. **Download the Resource**: Clone or [download](https://github.com/trickwire-labs/tl_socialhousing/archive/refs/heads/main.zip) this repository into your `resources` folder.
   ```bash
   git clone https://github.com/trickwire-labs/social-housing.git
   ```
2. **Add to Server Config**: Ensure the resource is added to your `server.cfg`.
   ```bash
   ensure tl_socialhousing
   ```
3. **Configure**: Customize the `config.lua` and `locale.lua` files to fit your server's needs.
4. **SQL setup**: Run the query found in `install.sql` in your database management system.
5. **Inventory setup**: If you plan on having players need a "key" item, add the following item to `ox_inventory/data/items.lua`:
   ```lua
   ['socialhousekey'] = { --Change 'socialhousekey' to whatever name you have configured in the `config.lua` file.
		label = 'Social house key',
		weight = 80,
	},
   ``
6. **Restart Your Server**: Restart your FiveM server to apply the changes.

---

## 📸 Screenshots 📸

![image](https://github.com/user-attachments/assets/ed6a3607-b485-477c-8686-bd337424e420)
*One of the preconfigured houses*

![image](https://github.com/user-attachments/assets/2a89d49a-c1ee-497f-adbd-56e9096b7082)
*Seller interaction menu*

---

## 🤝 Contributing 🤝

We welcome contributions. If you'd like to contribute to this resource, please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with a detailed description of your changes.

---

## 📄 License 📄

This project is licensed under the GPL-3.0 license. See the [LICENSE](LICENSE) file for more details.

---

## 💬 Support & Feedback 💬

Have questions, suggestions, or need help? Join our [Discord server](https://discord.gg/q7Sq9wJhbR) or open an issue on GitHub. We'd love to hear from you!

---

## 🌐 Connect with us 🌐

- **GitHub**: [Seven](https://github.com/squarerootof49)
- **Github**: [Trickwire Labs](https://github.com/trickwire-labs)
- **Discord**: [Join our Community](https://discord.gg/q7Sq9wJhbR)
- **FiveM Forum**: [tl_socialhousing thread] (TBD)

---

Thank you for viewing **tl_socialhousing** :\)
