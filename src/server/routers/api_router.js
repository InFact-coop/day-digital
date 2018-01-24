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
    cloudinary.uploader.upload(`${req.file.path}.mp4`, function(err, result) {
      if (err) { console.log('err', err); };
      console.log(result);
      return res.send ('IT WORKED');
    }, { resource_type: "video" });
  });
});

module.exports = router;
