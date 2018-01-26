require("../../config.js");
const path = require("path");
const express = require("express");
const bodyParser = require("body-parser");
const api_router = require("./routers/api_router");
var multer = require("multer");
var upload = multer({ dest: "uploads/" });
var sslRedirect = require("heroku-ssl-redirect");

const app = express();

app.use(express.static(path.join(__dirname, "../../public")));
app.use(sslRedirect());
app.use(bodyParser.json());
app.use(upload.single("recordingData"));
app.use(express.static("public"));

app.use("/api/v1/", api_router);

module.exports = app;
