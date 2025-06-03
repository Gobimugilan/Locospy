document.addEventListener("DOMContentLoaded", () => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(async position => {
      const lat = position.coords.latitude;
      const lon = position.coords.longitude;

      // Send to backend
      fetch('/location', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ latitude: lat, longitude: lon })
      });

      // Display to user
      document.getElementById("coords").innerText = `📍 Latitude: ${lat.toFixed(4)} | Longitude: ${lon.toFixed(4)}`;

      const res = await fetch(`https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lon}&format=json`);
      const data = await res.json();
      const city = data.address.city || data.address.town || data.address.village || data.address.state || "Unknown";
      const country = data.address.country || "Unknown";
      document.getElementById("location").innerText = `🗺️ You are in ${city}, ${country}`;

      const time = new Date().toLocaleString("en-US", { timeZoneName: "short" });
      document.getElementById("timezone").innerText = `⏰ Local Time: ${time}`;

      const sun = await fetch(`https://api.sunrise-sunset.org/json?lat=${lat}&lng=${lon}&formatted=0`);
      const sunData = await sun.json();
      const sunrise = new Date(sunData.results.sunrise).toLocaleTimeString();
      const sunset = new Date(sunData.results.sunset).toLocaleTimeString();
      document.getElementById("sun").innerText = `🌅 Sunrise: ${sunrise} | 🌇 Sunset: ${sunset}`;

      const facts = [
        "You are closer to the Earth's core than Mt. Everest!",
        "The Earth rotates at 1,670 km/h at the equator.",
        "You're on a planet orbiting at 107,000 km/h.",
        "Everyone sees the same stars—just at different times.",
        "You're standing on one of Earth's 7 tectonic plates."
      ];
      document.getElementById("fact").innerText = facts[Math.floor(Math.random() * facts.length)];
    });
  }
});
