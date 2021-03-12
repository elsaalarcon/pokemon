charge = Stripe::Charge.create({
  amount: 2000,
  currency: "usd",
  billing_details: {
    address:{
      city: 'los angeles',
      country: 'los angeles',
      postal_code: '20850',
      state: 'md' },
   email:'test@test.com',
   name: 'jose',
   phone: '301 239 908'},
  source: "tok_mastercard", # obtained with Stripe.js
  description: "My First Test Charge (created for API docs)"
}, {
  idempotency_key: "5SVPxIUauC3kkOwr"
})