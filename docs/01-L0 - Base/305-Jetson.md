# Jetson Orin Nano Super

## Jetson Orin Nano Super Developer Kit

The “Super” designation comes from the introduction of a new power mode. The Orin Nano Super has a 25 Watt power mode, which increases performance from between 30 to 70% over the 15 Watt mode. This is accomplished by adjusting three parameters.

Memory bandwidth: Increased from 64 GB/s to 102 GB/s (Giga Bytes per second)
Boost CPU frequency to 1.7 GHz
Boost GPU frequency to 1020 MHz
This is the power draw for the Jetson module itself, the carrier board and attached peripherals have their own power budget. The carrier board can supply up to 45 Watts, providing ample power for the module and peripherals.

## Overview

![](images/jetson-orin-nano-qtr_numbered.png)

(1) microSD card slot for main storage
(2) 40-pin expansion header
(3) Power indicator LED
(4) USB-C port for data only
(5) Gigabit Ethernet port
(6) USB 3.1 Type A ports (x4)
(7) DisplayPort connector
(8) DC Barrel jack for 19V power input
(9) MIPI CSI camera connectors

## Jetson Orin Nano Super Developer Kit configuration

| | NVIDIA Jetson Orin Nano Developer Kit (original) | NVIDIA Jetson Orin Nano Super Developer Kit |
|-|-|-|
| GPU | NVIDIA Ampere architecture <br> 1,024 CUDA Cores <br> 32 Tensor Cores <br> 635 MHz	| NVIDIA Ampere architecture <br>  1,024 CUDA Cores <br>  32 Tensor Cores <br> 1,020 MHz |
| AI PERF	| 40 INT8 TOPS (Sparse) <br> 20 INT8 TOPS (Dense) <br> 10 FP16 TFLOPs | 	67 TOPS (Sparse) <br> 33 TOPS (Dense) <br> 17 FP16 TFLOPs |
| CPU |	6-core Arm Cortex-A78AE v8.2 64-bit CPU <br>  1.5 GHz | 6-core Arm Cortex-A78AE v8.2 64-bit CPU <br> 1.7 GHz |
| Memory | 8GB 128-bit LPDDR5 <br>  68 GB/s | 8GB 128-bit LPDDR5 <br> 102 GB/s |
| MODULE POWER | 7W  15W | 7W  15W  25W |

## SSD Install

### Background

The Jetson Orin Nano Developer Kit has two M.2 Key M slots which allow installation of PCIe SSDs. You can boot the system from the SSD, bypassing the SD card. A SSD is much faster than the default storage medium of a SD card (5-10X in practice).

### Selecting a SSD

Here are some things to keep in mind when buying a SSD for your Jetson Orin Nano Developer Kit. The first is that you must use a PCIe SSD. SSDs are available in two flavors, PCIe and SATA. Many PCs use SATA drives, so you have to be careful when buying. Typically SATA drives have two notches on their connector edge, while the PCIe drives have only one. The SATA drives no-worky on the Jetson.

The second thing to know is that the Orin Nano Devkit NVMe slot is PCIe Gen 3. Which means that you won’t get Gen 4 speeds if you are using a Gen 4 drive. Most Gen 4 drives are compatible with the Orin Nano, but you usually pay a premium for no added benefit.

The third thing to know is that you should probably know how much power the drive draws. In the video for example, we’re using a 1TB drive with a power draw of 2.5A at 3.3V. This is 8.25W. The Orin Nano Devkit board can provide 36 watts total to the system. Unlike a traditional desktop, you need to keep track of your power budget. Remember that the Orin Nano SoC itself can use 15W (you would add a little more for a safety buffer). If you add in another 8W, that means you have about another 8-10 for other peripherals give or take. Smaller capacity drives tend to use less power.

Also, remember you’re going to need backups. Right? So a larger drive is not always a blessing.

## References

[Jetson Orin Nano Tutorial: SSD Install, Boot, and JetPack Setup](https://jetsonhacks.com/2023/05/30/jetson-orin-nano-tutorial-ssd-install-boot-and-jetpack-setup/#:~:text=Here%E2%80%99s%20a%20couple%20that)

[NVIDIA Jetson Orin Nano Developer Kit – The Perfect Solution for Makers and Developers: A Review](https://jetsonhacks.com/2023/03/22/nvidia-jetson-orin-nano-developer-kit-the-perfect-solution-for-makers-and-developers-a-review/)
