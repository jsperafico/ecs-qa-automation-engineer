
const axios = require('axios');

async function seed() {
  const tokenRes = await axios.post('http://localhost:3000/auth/token');
  const token = tokenRes.data.token;

  for (let i = 0; i < 10; i++) {
    try {
      res = await axios.post('http://localhost:3000/logs',
        { message: `seed-log-${i}` },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      console.log('Seed log created', res.data.correlationId);

      logStatus = await axios.get(`http://localhost:3000/logs/${res.data.correlationId}`);
      console.log('Log Status', logStatus.data);
    } catch (err) {
      console.error('Seed error', err.response?.status);
    }
  }
  console.log('Seeding completed');
}

seed();
