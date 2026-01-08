const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "kishore01kumar10@gmail.com",   // ✅ SYSTEM EMAIL
    pass: "APP_PASSWORD",                // ✅ Gmail App Password
  },
});

exports.sendOtpEmail = functions.https.onCall(async (data, context) => {
  const { email, otp } = data;

  if (!email || !otp) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Email and OTP required"
    );
  }

  const mailOptions = {
    from: `"SLEC Campus Connect" <kishore01kumar10@gmail.com>`, // ✅ FIXED
    to: email,                                                  // ✅ STUDENT EMAIL
    subject: "Password Reset OTP - SLEC",
    html: `
      <h2>Password Reset</h2>
      <p>Your OTP code is:</p>
      <h1 style="letter-spacing:4px">${otp}</h1>
      <p>This OTP is valid for 5 minutes.</p>
      <br/>
      <p>– SLEC Campus Connect</p>
    `,
  };

  try {
    await transporter.sendMail(mailOptions);
    return { success: true };
  } catch (error) {
    console.error(error);
    throw new functions.https.HttpsError("internal", "Email failed");
  }
});
