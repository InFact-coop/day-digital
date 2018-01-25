if (!navigator.mediaDevices) {
  alert("getUserMedia support required to use this page");
}

app.ports.prepareVideo.subscribe(function() {
  const videoChunks = [];
  let onDataAvailable = e => {
    videoChunks.push(e.data);
  };

  navigator.mediaDevices
    .getUserMedia({
      audio: true,
      video: {
        width: { ideal: 1280 },
        height: { ideal: 720 }
      }
    })
    .then(mediaStream => {
      const recorder = new MediaRecorder(mediaStream);
      recorder.ondataavailable = onDataAvailable;
      const video = document.querySelector("video");
      const url = window.URL.createObjectURL(mediaStream);
      app.ports.liveVideoUrl.send(url);
      // video.src = url;
      app.ports.recordStart.subscribe(function() {
        recorder.start();
        console.log(recorder.state);
        console.log("recorder started");
      });

      app.ports.recordStop.subscribe(function() {
        if (recorder) {
          recorder.stop();
          mediaStream.getTracks().map(function(track) {
            track.stop();
          });
          console.log(recorder.state);
          console.log("recorder stopped");
        }
      });

      recorder.onstop = e => {
        console.log("e: ", e);
        console.log("videoChunks: ", videoChunks);
        const bigVideoBlob = new Blob(videoChunks, { type: "video/mp4" });
        var videoURL = window.URL.createObjectURL(bigVideoBlob);
        app.ports.recordedVideoUrl.send(videoURL);

        let fd = new FormData();
        fd.append("recordingData", bigVideoBlob);
        fetch("/api/v1/video-upload", {
          method: "POST",
          body: fd
        })
          .then(response => response.json())
          .then(response => console.log("Success", response))
          .catch(error => console.log("Error", error));
      };
    })
    .catch(function(err) {
      console.log("error", err);
      app.ports.recordError.send("Can't start video!");
    });
});
