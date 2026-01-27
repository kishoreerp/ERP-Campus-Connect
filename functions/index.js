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

exports.resetPasswordWithOtp = functions.https.onRequest(
  async (req, res) => {
    try {
      const { email, newPassword } = req.body;

      if (!email || !newPassword) {
        return res.status(400).json({ error: "Missing data" });
      }

      // 🔎 Check OTP verification
      const otpDoc = await admin
        .firestore()
        .collection("email_otps")
        .doc(email)
        .get();

      if (!otpDoc.exists || otpDoc.data().verified !== true) {
        return res.status(403).json({ error: "OTP not verified" });
      }

      // 🔐 Update password using Admin SDK
      const user = await admin.auth().getUserByEmail(email);
      await admin.auth().updateUser(user.uid, {
        password: newPassword,
      });

      // 🧹 Cleanup OTP
      await admin.firestore().collection("email_otps").doc(email).delete();

      return res.json({ success: true });
    } catch (err) {
      console.error(err);
      return res.status(500).json({ error: err.message });
    }
  }
);
