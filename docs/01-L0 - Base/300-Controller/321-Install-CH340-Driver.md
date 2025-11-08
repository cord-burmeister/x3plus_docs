# CH341 Driver Installation

!!! warning "Missing CH341 Driver Installation with Kernel 36 Revision 4.7"
    The NVIDIA image with R36 Revision 4.7 does not contain the driver for CH341 and will not (as of November 2025) Kernel Sources to build modules the NVIDIA Way.

## CH341 Driver Installation via Command Line (Linux)

### 1. Check if the driver is already present

- The CH341 driver has been included in the Linux kernel since version 2.6.24.
- Run:

  ```bash
  lsmod | grep ch341
  ```

  If listed, it's already loaded.

### 2. Download and prepare the driver

- Clone the official WCH repository:

  ```bash
  git clone https://github.com/WCHSoftGroup/ch341ser_linux.git
  cd ch341ser_linux/driver
  ```

### 3. Compile the driver

- Run:

  ```bash
  make
  ```

  This generates the `ch341.ko` kernel module.

### 4. Load the driver dynamically

- Use either of these:

  ```bash
  sudo make load
  # or
  sudo insmod ch341.ko
  ```

### 5. Install the driver permanently

- Run:

  ```bash
  sudo make install
  ```

### 6. Verify device connection

- Plug in your CH341 device and check:

  ```bash
  dmesg | grep ch341
  lsusb
  ls /dev/ttyCH341USB*
  ```

### 7. Set user permissions (if needed)

- Add your user to the `dialout` group:

  ```bash
  sudo usermod -a -G dialout $USER
  sudo chmod a+rw /dev/ttyCH341USB0
  ```

### Uninstalling the Driver

- To unload or remove:

  ```bash
  sudo make unload
  # or
  sudo rmmod ch341.ko
  sudo make uninstall
  ```

## References

[WCH GitHub repo](https://github.com/WCHSoftGroup/ch341ser_linux): USB serial driver for USB to UART chip ch340, ch341, etc. ch341.

[How to Install CH341SER Arduino Clone Driver in Linux](https://www.srishtirobotics.com/more/blog/170-how-to-install-ch341ser-arduino-clone-driver-in-linux): How to Install CH341SER Arduino Clone Driver in Linux
