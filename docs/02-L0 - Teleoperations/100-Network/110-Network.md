# ROS 2 and Network

Integrating ROS 2 into a network—whether it's a local LAN or across the internet—requires careful setup to ensure reliable communication between nodes. Here are some best practices to guide you through it:

## Core Concepts of ROS 2 Networking

- **DDS Middleware**: ROS 2 uses DDS (Data Distribution Service) for communication. This enables automatic node discovery and message exchange across devices.
- **Multicast Support**: Devices on the same subnet can discover each other via multicast, which is enabled by default.
- **Domain ID**: ROS 2 networks are segmented using Domain IDs. Nodes with the same Domain ID can communicate.

## Best Practices for LAN Integration

1. **Same Subnet**: Ensure all devices are on the same LAN and subnet.
2. **Multicast Enabled**: Verify that your network supports multicast traffic.
3. **Firewall Configuration**: Allow UDP traffic on ports used by DDS (typically 7400–7600).
4. **Hostname Resolution**: Use static IPs or ensure proper DNS resolution between devices.
5. **QoS Settings**: Tune Quality of Service parameters to match your network reliability and latency needs.

Example setup:

```bash
# On ROSbot
ros2 topic pub -r 1 /msg std_msgs/msg/String "data: 'Hello from ROSbot'"

# On Laptop
ros2 topic echo /msg
```

You should see the message echoed if everything is configured correctly.

## Best Practices for Internet Integration

1. **VPN Solutions**: Use VPNs like [Husarnet](https://husarnet.com/blog/ros2-docker) to securely connect devices over the internet.
2. **Firewall/NAT Traversal**: VPNs help bypass NAT and firewall restrictions.
3. **Security**: Encrypt traffic and authenticate devices to prevent unauthorized access.
4. **Bandwidth Management**: Avoid flooding the network with high-frequency or large messages.

## Troubleshooting Tips

- **Check ROS 2 Daemon**: Ensure it's running to support node discovery.
- **Monitor Network Load**: Excessive messages or poor hardware can cause dropped connections.
- **Use Discovery Server**: For large networks, consider centralized discovery to reduce multicast traffic.

## References

[Husarion tutorial step-by-step guide for both LAN and internet setups](https://husarion.com/tutorials/ros2-tutorials/6-robot-network/)
