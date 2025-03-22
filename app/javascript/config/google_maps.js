function initializeGoogleMapsAPI() {
  const script = document.createElement('script');
  console.log(process.env.GOOGLE_API_KEY);
  script.src = `https://maps.googleapis.com/maps/api/js?key=$ENV["GOOGLE_API_KEY"]&libraries=places`;
  script.async = true;
  // script.defer = true;
  document.head.appendChild(script);
  console.log("script", script);

  script.onload = () => {
    console.log('Google Maps API initialized successfully');
  };

  script.onerror = () => {
    console.error('Error loading Google Maps API');
  };
}

initializeGoogleMapsAPI();
