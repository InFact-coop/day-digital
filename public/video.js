const record = document.getElementById('record')
const stop = document.getElementById('stop')

if (!navigator.mediaDevices){
  alert('getUserMedia support required to use this page')
}

const chunks = []
let onDataAvailable = (e) => {
  chunks.push(e.data)
}

// Not showing vendor prefixes.
navigator.mediaDevices.getUserMedia({
  audio: true,
  video: {
    width: { ideal: 1280 },
    height: { ideal: 720 }
  }
}).then((mediaStream) => {
  const recorder = new MediaRecorder(mediaStream)
  recorder.ondataavailable = onDataAvailable
  const video = document.querySelector('video')
  const url = window.URL.createObjectURL(mediaStream)
  video.src = url

  record.onclick = () => {
    recorder.start()
    document.getElementById('status').innerHTML = 'recorder started'
    console.log(recorder.state)
    console.log('recorder started')
  }

  stop.onclick = ()=> {
    recorder.stop()
    console.log(recorder.state)
    document.getElementById('status').innerHTML = 'recorder started'
    console.log('recorder stopped')
  }

  video.onloadedmetadata = (e) => {
    console.log('onloadedmetadata', e)
  }

  recorder.onstop = (e) => {
    console.log('e', e)
    console.log('chunks', chunks)
    const bigVideoBlob = new Blob(chunks, { 'type' : 'video/mp4' })
    let fd = new FormData()
    fd.append('videoData', bigVideoBlob)
    fetch("/api/v1/video-upload", {
      method: 'POST',
      body: fd
    })
    .then(response => response.json())
    .then(response => console.log('Success', response))
    .catch(error => console.log('Error', error))
  }
}).catch(function(err){
  console.log('error', err)
})
