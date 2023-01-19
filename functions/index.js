const functions = require("firebase-functions");
const { RtcTokenBuilder, RtcRole } = require("agora-access-token");
const nodeMailer = require("nodemailer");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const stripe = require("stripe")(functions.config().stripe.secret_key);
const stripetest = require("stripe")(functions.config().stripe.secret_key_test);

exports.stripePayment = functions.https.onRequest(async (req, res) => {
  const paymentIntent = await stripe.paymentIntents.create(
    {
      amount: parseInt(req.body.amount),
      currency: req.body.currency,
      customer: req.body.customer_id,
    },
    function (error, paymentIntent) {
      if (error != null) {
        console.log(error);
      } else {
        res.json({
          paymentIntent: paymentIntent.client_secret,
          paymentIntentData: paymentIntent,
          amount: req.body.amount,
          currency: req.body.currency,
        });
      }
    }
  );
});

exports.createStripeCustomer = functions.https.onRequest(async (req, res) => {
  let description = req.body.description;
  let email = req.body.email;

  const customer = await stripetest.customers.create({
    email: email,
    description: description,
  });

  res.json({ body: customer });
});

exports.retrieveStripeCustomer = functions.https.onRequest(async (req, res) => {
  let customerId = req.body.id;
  const customer = await stripetest.customers.retrieve(customerId);
  res.json({ body: customer });
});

exports.updateStripeCustomer = functions.https.onRequest(async (req, res) => {
  let customerId = req.body.id;
  let name = req.body.name;
  const customer = await stripetest.customers.update(customerId, {
    name: name,
  });
  res.json({ body: customer });
});

exports.stripePaymentTest = functions.https.onRequest(async (req, res) => {
  const paymentIntent = await stripetest.paymentIntents.create(
    {
      amount: parseInt(req.body.amount),
      currency: req.body.currency,
      customer: req.body.customer_id,
    },
    function (error, paymentIntent) {
      if (error != null) {
        console.log(error);
        res.json({ error: error });
      } else {
        res.json({
          paymentIntent: paymentIntent.client_secret,
          paymentIntentData: paymentIntent,
          amount: req.body.amount,
          currency: req.body.currency,
        });
      }
    }
  );
});

exports.generateToken = functions.https.onRequest((req, res) => {
  const APP_ID = functions.config().agora.appid;
  const APP_CERTIFICATE = functions.config().agora.appcertificate;

  res.header("Access-Control-Allow-Origin", "*");
  console.log("params", req.query);
  const channelName = req.query.channel;
  if (!channelName) {
    return res.status(500).json({ error: "channel is required" });
  }

  let uid = req.query.uid;
  if (!uid || uid === "") {
    uid = 0;
  }
  // get role
  let role;
  if (req.query.role === "publisher") {
    role = RtcRole.PUBLISHER;
  } else if (req.query.role === "audience") {
    role = RtcRole.SUBSCRIBER;
  } else {
    return res.status(500).json({ error: "role is incorrect" });
  }

  let expireTime = req.query.expiry;
  if (!expireTime || expireTime === "") {
    expireTime = 3600;
  } else {
    expireTime = parseInt(expireTime, 10);
  }
  const currentTime = Math.floor(Date.now() / 1000);
  const privilegeExpireTime = currentTime + expireTime;

  let token;
  if (req.query.tokentype === "userAccount") {
    token = RtcTokenBuilder.buildTokenWithAccount(
      APP_ID,
      APP_CERTIFICATE,
      channelName,
      uid,
      role,
      privilegeExpireTime
    );
    return res.json({ rtcToken: token });
  } else if (req.query.tokentype === "uid") {
    console.log("appid", APP_ID);
    console.log("appcertificate", APP_CERTIFICATE);
    token = RtcTokenBuilder.buildTokenWithUid(
      APP_ID,
      APP_CERTIFICATE,
      channelName,
      uid,
      role,
      privilegeExpireTime
    );
    return res.json({ rtcToken: token });
  } else {
    return res.status(500).json({ error: "token type is invalid" });
  }
});

exports.sendMail = functions.https.onRequest((req, res) => {
  const to = req.body.to;
  const text = req.body.text;
  const subject = req.body.subject;

  var transporter = nodeMailer.createTransport({
    service: "smtp",
    auth: {
      user: "support@thedeploy.xyz",
      pass: "@Manthan6268426",
    },
    port: 587,
    host: "smtp.hostinger.com",
  });

  let mailOptions = {
    from: "support@thedeploy.xyz",
    to: to,
    subject: subject,
    html: text,
    text: text,
  };

  transporter.sendMail(mailOptions, (err) => {
    if (err === null) {
      res.send({ status: "success" });
    } else {
      res.send({ status: "error" + err });
    }
  });
});
