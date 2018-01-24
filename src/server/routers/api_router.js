const router = require("express").Router();
const Airtable = require("airtable");
const base = Airtable.base(process.env.AIRTABLE_BASE);
const fs = require('fs')
const cloudinary = require('cloudinary');

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUDNAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET
});

Airtable.configure({
  endpointUrl: "https://api.airtable.com",
  apiKey: process.env.AIRTABLE_API_KEY
});

router.route("/help_form").post((req, res, next) => {
  base(process.env.AIRTABLE_TABLE).create(req.body, (err, record) => {
    if (err) {
      return res.json({ success: false });
    }
    return res.json({ success: true });
  });
});

router.route("/video-upload").post((req, res, next) => {
  fs.rename(req.file.path, `${req.file.path}.mp4`, function (err) {
    // cloudinary documentation is wrong here, for uploader.upload the callback is the second argument and the options are the third
    // the callback also has the arguments the wrong way round with the 'result' going first and the 'err' last
    cloudinary.uploader.upload(`${req.file.path}.mp4`, function(result, err) {
      if (err) { console.log('err', err); };
      console.log('result', result);
      return res.json({ success: true });
    }, { resource_type: "video" });
  });
});

module.exports = router;
