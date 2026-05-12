require("dotenv").config();

const express = require("express");
const cors = require("cors");
const Stripe = require("stripe");

const app = express();

app.use(cors());
app.use(express.json());

function maskKey(key) {
  if (!key) return "MISSING";
  return `${key.substring(0, 12)}...${key.substring(key.length - 6)} length=${key.length}`;
}

console.log("Stripe key loaded:", process.env.STRIPE_SECRET_KEY ? "YES" : "NO");
console.log("Current folder:", process.cwd());
console.log("STRIPE_SECRET_KEY:", maskKey(process.env.STRIPE_SECRET_KEY));
console.log("PORT:", process.env.PORT);

const stripe = Stripe(process.env.STRIPE_SECRET_KEY);

app.post("/create-payment-intent", async (req, res) => {
  try {
    console.log("Payment intent request received:", req.body);

    const { amount } = req.body;

    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount,
      currency: "nzd",
      automatic_payment_methods: {
        enabled: true,
      },
    });

    console.log("PaymentIntent created:", paymentIntent.id);

    res.send({
      clientSecret: paymentIntent.client_secret,
    });
  } catch (error) {
    console.log("Stripe server error:", error.message);

    res.status(400).send({
      error: error.message,
    });
  }
});

app.listen(process.env.PORT || 4242, "0.0.0.0", () => {
  console.log(`Stripe server running on port ${process.env.PORT || 4242}`);
});
