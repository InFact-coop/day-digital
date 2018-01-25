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
      console.log('recorder', recorder);
      recorder.ondataavailable = onDataAvailable;
      const url = window.URL.createObjectURL(mediaStream);
      app.ports.liveVideoUrl.send(url);
      // video.src = url;
      app.ports.recordStart.subscribe(function() {
        console.log('recorder', recorder);
        console.log('mediaStream', mediaStream);
        console.log('HELLO DARKNESS MY OLD FRIEND');
        if (recorder.state !== 'recording') {
          recorder.start();
        }
        console.log(recorder.state);
        console.log('recorder started');
      });

      app.ports.recordStop.subscribe(function() {
        if (recorder.state !== 'inactive') {
          recorder.stop();
          mediaStream.getTracks().map(function(track) {
            track.stop();
          });
        }
        console.log(recorder.state);
        console.log('recorder stopped');
      });

      recorder.onstop = e => {
        const bigVideoBlob = new Blob(videoChunks, { type: "video/mp4" });
        console.log('e: ', e);
        console.log('videoChunks: ', videoChunks);
        var videoURL = window.URL.createObjectURL(bigVideoBlob);
        app.ports.recordedVideoUrl.send(videoURL);
      };
    })
    .catch(function(err) {
      console.log('error', err);
      app.ports.recordError.send("Can't start video!");
    });

  app.ports.uploadVideo.subscribe(function(questionNumber) {
    let fd = new FormData();
    fd.append('recordingData', bigVideoBlob);
    fd.append('question', questionNumber);
    fetch('/api/v1/video-upload', {
      method: 'POST',
      body: fd
    })
      .then(response => response.json())
      .then(response => {
        console.log('Success', response);
        if (response.q1) {
          app.ports.getQ1Url.send(response.q1);
        } else if (response.q2) {
          app.ports.getQ2Url.send(response.q2);
        } else {
          app.ports.getQ3Url.send(response.q3);
        }
      })
      .catch(error => console.log('Error', error));
  });
});
