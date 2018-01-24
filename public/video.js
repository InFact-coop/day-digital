if (!navigator.mediaDevices) {
  alert("getUserMedia support required to use this page");
}

const chunks = [];
let onDataAvailable = e => {
  chunks.push(e.data);
};

app.ports.videoRoute.subscribe(function() {
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
        console.log("chunks: ", chunks);
        const bigVideoBlob = new Blob(chunks, { type: "video/mp4" });
        var videoURL = window.URL.createObjectURL(bigVideoBlob);
        app.ports.videoUrl.send(videoURL);

        let fd = new FormData();
        fd.append("videoData", bigVideoBlob);
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
