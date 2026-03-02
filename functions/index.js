const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "solveinspire.team@gmail.com",   // ✅ SYSTEM EMAIL
    pass: "updbcambpgfeznmj",                // ✅ Gmail App Password
  },
});

const { onCall } = require("firebase-functions/v2/https");

exports.sendOtpEmail = onCall(async (request) => {
  const { email, otp } = request.data;
  

  if (!email || !otp) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Email and OTP required"
    );
  }

  const mailOptions = {
    from: `"SLEC Campus Connect" <solveinspire.team@gmail.com>`, // ✅ FIXED
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

const cors = require("cors")({ origin: true });

const { onRequest } = require("firebase-functions/v1/https");

exports.resetPasswordWithOtp = onRequest(
  { region: "asia-south1", cors: true },
  async (req, res) => {
    try {
      if (req.method !== "POST") {
        return res.status(405).json({ error: "Method not allowed" });
      }

      const { email, newPassword } = req.body;

      if (!email || !newPassword) {
        return res.status(400).json({ error: "Missing data" });
      }

      const otpDoc = await admin
        .firestore()
        .collection("email_otps")
        .doc(email)
        .get();

      if (!otpDoc.exists || otpDoc.data().verified !== true) {
        return res.status(403).json({ error: "OTP not verified" });
      }

      const user = await admin.auth().getUserByEmail(email);

      await admin.auth().updateUser(user.uid, {
        password: newPassword,
      });

      await admin.firestore().collection("email_otps").doc(email).delete();

      return res.json({ success: true });
    } catch (err) {
      console.error(err);
      return res.status(500).json({ error: err.message });
    }
  }
);

  // ================= DELETE STUDENT (AUTH + FIRESTORE) =================

exports.deleteStudentUser = functions.firestore
  .document("delete_requests/{uid}")
  .onCreate(async (snap, context) => {
    const uid = context.params.uid;

    try {
      console.log("Delete request received for UID:", uid);

      // 🔐 Delete from Firebase Authentication
      await admin.auth().deleteUser(uid);

      // 🗄 Delete from Firestore
      await admin.firestore().collection("users").doc(uid).delete();

      // 🧹 Remove delete request document
      await snap.ref.delete();

      console.log("Student deleted successfully:", uid);
    } catch (error) {
      console.error("Error deleting student:", error);
    }
  });

// ================= ADMISSION CONFIRMATION EMAIL =================
exports.sendAdmissionConfirmation = functions
  .region("asia-south1") // 👈 ADD THIS
  .firestore
  .document("admission_forms/{docId}")
  .onCreate(async (snap, context) => {
    try {
      const data = snap.data();

      const mailOptions = {
        from: `"SLEC Campus Connect" <kishore01kumar10@gmail.com>`,
        to: data.email,
        subject: "Application Submitted Successfully - SLEC",
        html: `
          <h2>Application Submitted Successfully</h2>

          <p>Dear <b>${data.fullName}</b>,</p>

          <p>
            Your application for 
            <b>${data.department}</b> (${data.program} - ${data.degree})
            has been received successfully.
          </p>

          <p><b>Status:</b> Pending Review</p>

          <br/>

          <p>
            Our admission team will review your application and contact you soon.
          </p>

          <br/>

          <p>
            Regards,<br/>
            <b>St. Lourdes Engineering College</b><br/>
            Thanir Arul Nagar, Perambalur
          </p>
        `,
      };

      await transporter.sendMail(mailOptions);

      console.log("Admission confirmation email sent to:", data.email);
    } catch (error) {
      console.error("Error sending admission confirmation:", error);
    }
  });

  // ================= apllication accept reject mail =================
  exports.sendAdmissionStatusEmail = onCall(async (request) => {

  const { email, status } = request.data;

  let subject;
  let html;

  if (status === "approved") {
    subject = "Admission Approved - SLEC";
    html = `
      <h2>Congratulations!</h2>
      <p>Your admission has been <b>approved</b>.</p>
      <p>Please visit the college within the next <b>15 working days</b> 
      to complete admission formalities.</p>
      <br/>
      <p>– SLEC Campus Connect</p>
    `;
  } else {
    subject = "Admission Application Status - SLEC";
    html = `
      <h2>Admission Update</h2>
      <p>We regret to inform you that your application 
      has been <b>rejected</b>.</p>
      <p>For further clarification, contact admission office.</p>
      <br/>
      <p>– SLEC Campus Connect</p>
    `;
  }

  await transporter.sendMail({
    from: "SLEC Campus Connect <kishore01kumar10@gmail.com>",
    to: email,
    subject: subject,
    html: html,
  });

  return { success: true };
});