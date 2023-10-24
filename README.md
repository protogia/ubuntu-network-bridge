# Setup network-bridge between two interfaces and enable routing

You want to connect two hosts **_A and C_** by bridging over a third host **_B_**?

```mermaid
graph TB
  subgraph HOST_A
    A_eth0[eth0]
  end

  subgraph HOST_B
    B_eth0[eth0]
    B_eth1[eth1]
  end

  subgraph HOST_C
    C_eth0[eth0]
  end

  A_eth0 -->|Communicate| B_eth0
  B_eth1 -->|Communicate| C_eth0

  B_eth0 -->|Communicate| A_eth0
  C_eth0 -->|Communicate| B_eth1
```

Here is your solution:

## Setup bridge on HOST_B

## Add route to bridge on HOST C
