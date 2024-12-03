# LinuxMonitoring

## Real-time monitoring and system analysis

This project is a set of scripts and tools for monitoring and analyzing the system state. Throughout the process, I completed several tasks, each addressing a specific issue related to monitoring and file system operations.

---

### 🚀 How to Use
1. Clone the repository:
   ```bash
   git clone git@github.com:kieuhaiha/Linux_Monitoring.git
   ```
2. Navigate to the project folder:
   ```bash
   cd Linux_Monitoring
   ```
---

### 🛠 Requirements
- Ubuntu Server 20.04 LTS
- Bash 5.0 or higher
- Installed utilities: `awk`, `df`, `GoAccess`, `Prometheus`, `Grafana`, `stress`, `iperf3`

---

## Completed Tasks

### 1. Generating Test Files and Directories
**What was done:**  
I developed a script to automatically create a structure of directories and files based on specific parameters. The script includes:
- Creation of directories with unique names based on the given parameters.
- Generation of files with specific sizes and formats.
- Free space monitoring (the script stops when the free space reaches 1 GB).

**Why:**  
This script helps to set up a test environment for monitoring and analysis, simulating real-world scenarios of file system load.

---

### 2. File System Cluttering
**What was done:**  
I wrote a script that randomly creates files and directories across the system (excluding certain directories like `bin` or `sbin`). The script:
- Generates random names for files and directories.
- Creates them in random locations.
- Stops when the free space reaches a predefined limit.

**Why:**  
This task helps to test monitoring systems by simulating file system clutter scenarios.

---

### 3. Cleaning the File System
**What was done:**  
I developed a script to delete files and directories created by the previous scripts. It supports three cleaning methods:
1. Using a log file.
2. By creation date and time.
3. By name pattern.

**Why:**  
This solution is essential for quickly resolving issues caused by incorrect operations or for cleaning up test data after experiments.

---

### 4. Generating Nginx Logs
**What was done:**  
I created a script to generate Nginx log files in a combined format. The logs include:
- Random IP addresses.
- HTTP methods (GET, POST, etc.).
- Server responses (2xx, 4xx, 5xx).
- Random requests and dates.

**Why:**  
The logs are used to test analysis systems, including GoAccess, Prometheus, and Grafana.

---

### 5. Log Analysis
**What was done:**  
I created a script to analyze Nginx logs using `awk`. It can:
- Sort records by response codes.
- Output unique IP addresses.
- Display requests with errors (4xx and 5xx).
- Show IP addresses associated with erroneous requests.

**Why:**  
This analysis helps to quickly identify problems in the system and their sources.

---

### 6. Visualization with GoAccess
**What was done:**  
I configured the GoAccess utility to visualize Nginx log data and opened its web interface for easier access.

**Why:**  
GoAccess provides a convenient way to visually analyze logs in real time.

---

### 7. Monitoring with Prometheus and Grafana
**What was done:**  
- Installed and configured Prometheus and Grafana on a virtual machine.
- Created a dashboard to monitor CPU, RAM, disk space, and I/O operations.
- Conducted stress testing using the `stress` utility.

**Why:**  
These tools offer powerful capabilities for monitoring system metrics and analyzing performance.

---

### 8. Preconfigured Monitoring Dashboard
**What was done:**  
I downloaded and configured a ready-made monitoring dashboard from Grafana Labs (Node Exporter Quickstart and Dashboard). I conducted network and disk tests to check interface loads.

**Why:**  
Using prebuilt solutions speeds up the setup process for monitoring and analysis.

---

### 9. Custom Node Exporter
**What was done:**  
I wrote a script that collects key system metrics (CPU, RAM, disk space) and generates a Prometheus-compatible page. This page updates automatically.

**Why:**  
This solution provides deeper insights into how monitoring tools work and allows the creation of custom metrics for specific tasks.

---

## Summary
The LinuxMonitoring project helped me gain a deeper understanding of monitoring systems, learn how to create and analyze logs, visualize data, and develop efficient Bash scripts for automation. I can now apply this knowledge to manage and optimize system resources in real time.

