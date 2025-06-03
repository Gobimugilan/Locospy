# locospy

**locospy** is a simple and effective Location Spy Tool built with Flask and a Bash launcher script.  
It captures the visitor’s GPS location automatically when they open a generated URL and displays live location data (latitude, longitude, Google Maps link) in your terminal.  

It supports running locally or exposing your Flask server publicly via Cloudflare Tunnel for remote tracking.

---

## Features

- Automatically captures GPS location from visitor's browser (no UI needed)
- Shows live location updates in your terminal
- Provides a Cloudflare Tunnel option to expose the tool publicly
- Minimal and blank webpage interface for stealthy operation

---

## Requirements

- Python 3.x
- Flask (`pip install flask`)
- Cloudflare Tunnel (cloudflared) installed and in your PATH
- Bash shell (Linux/macOS; Windows users can use WSL)

---

## Setup & Usage

1. Clone the repo:
    ```bash
    git clone https://github.com/yourusername/locospy.git
    cd locospy
    ```

2. Install Python dependencies:
    ```bash
    pip install flask
    ```

3. Make the launcher script executable:
    ```bash
    chmod +x locospy.sh
    ```

4. Run the tool:
    ```bash
    ./locospy.sh
    ```

5. Choose between:
    - Running locally at `http://127.0.0.1:5000`
    - Running publicly via Cloudflare Tunnel (public URL shown)

6. Share the URL with your target. When they open the link and allow location access, their GPS coordinates will appear live in your terminal.

---

## Files

- `app.py` — Flask backend server that receives and logs location data.
- `locospy.sh` — Bash script to launch Flask server and Cloudflare Tunnel, and show live location updates.
- `location.log` — Runtime file storing captured locations (auto-created and cleared on each run).

---

## Ethical Notice

This tool is intended for **educational and ethical use only**.  
Always obtain explicit consent before tracking any individual’s location. Misuse may violate privacy laws.

---

## Author

Developed by **glader**  
Follow me on Instagram: [_gobinathan_](https://instagram.com/_gobinathan_)

---

## License

MIT License — see [LICENSE](LICENSE) for details.
