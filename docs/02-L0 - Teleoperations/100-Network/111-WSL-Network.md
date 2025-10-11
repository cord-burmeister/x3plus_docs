# WSL and Network

## WSL Networking Basics

WSL creates a **virtual network interface** that allows your Linux environment to communicate with the Windows host and the internet.

## WSL 2 Network Details

WSL 2 runs in a lightweight VM, so it has its own **virtual Ethernet adapter** and IP address. Here's what that means:

- **Outbound connections** (e.g., `apt update`, `curl`) work out of the box.
- **Inbound connections** (e.g., running a web server in WSL) require:
  - Port forwarding using PowerShell or `netsh`
  - Firewall rules to allow traffic
- You can find the WSL IP using:  

  ```bash
  ip addr | grep eth0
  ```

## Communicating Between Windows & WSL

- **From WSL to Windows**: You can use `localhost` or the Windows IP.
- **From Windows to WSL**:
  - Use WSL's IP (check with `wsl hostname -I`)
  - Or forward ports manually:

    ```powershell
    netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=<WSL-IP>
    ```

## Pro Tip

If you're doing web development or running services inside WSL, consider using **WSLg** (for GUI apps) or **Docker Desktop with WSL integration**—they handle a lot of the networking quirks for you.

## Bridging WSL network

You **can bridge the network in WSL2** to make it accessible from remote devices, but it takes a few steps since WSL2 uses a **virtualized NAT network** by default. Bridging allows your WSL instance to appear as a peer device on your LAN, making it easier to access from other machines.

### Option 1: Use WSL2 Bridged Networking (Experimental Feature)

WSL2 now supports **bridged networking mode**, but you’ll need:

- **WSL version 0.51.2.0 or later**
- A **Hyper-V virtual switch** configured for bridging

#### Steps

#### Step 1: Enable Hyper-V (if not already enabled)

Open PowerShell as Administrator and run:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

Restart your machine if prompted.

#### Step 2: Create a Bridged Virtual Switch

1. Open **Hyper-V Manager** (search for it in the Start menu)
2. In the right pane, click **“Virtual Switch Manager…”**
3. Select **“New virtual network switch” → External**
4. Click **Create Virtual Switch**
5. Name it something like `wsl-switch`
6. Under **“External network”**, choose your active network adapter (e.g., Ethernet or Wi-Fi)
7. Check **“Allow management operating system to share this network adapter”**
8. Click **Apply** and **OK**

#### Step 3: Configure `.wslconfig`

Create or edit the `.wslconfig` file in your user profile folder (`C:\Users\<User>\.wslconfig`):

```ini
[wsl2]
networkingMode=bridged
vmSwitch=wsl-switch
```

Save the file.

#### Step 4: Restart WSL

Open PowerShell and run:

```powershell
wsl --shutdown
```

Then launch your WSL instance again. It should now get an IP address from your LAN.

#### Step 5: Test Remote Access

Inside WSL, run:

```bash
ip addr show eth0
```

Look for an IP like `192.168.x.x`. Try pinging it from another device on your network. If you're running a service (e.g., a web server), make sure it's listening on `0.0.0.0` and not just `localhost`.

### Option 2: Manual Network Bridge via Control Panel

If you prefer not to use Hyper-V:

1. Open **Control Panel → Network Connections**
2. Select both your physical network adapter (Ethernet/Wi-Fi) and the `vEthernet (WSL)` adapter
3. Right-click and choose **“Bridge Connections”**
4. Inside WSL, manually assign an IP:

   ```bash
   sudo ip addr flush dev eth0
   sudo ip addr add 192.168.1.244/24 dev eth0
   sudo ip link set eth0 up
   sudo ip route add default via 192.168.1.1 dev eth0
   ```

This gives your WSL instance a LAN IP, making it accessible remotely.

### Security Tip

If you're exposing services (like SSH, web servers), make sure to:

- Configure **firewall rules** on Windows
- Secure your services with **authentication and encryption**
