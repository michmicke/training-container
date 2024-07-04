import { createServer } from 'http';
import { PrismaClient } from '@prisma/client';
import express from 'express';
import bodyParser from 'body-parser';

import { countVisits } from './countVisits';

const app = express();
app.use(bodyParser.json());
const server = createServer(app);

const prisma = new PrismaClient();

app.post('/visits', async (req, res) => {
  const userIdentifier = req.body.name;

  if (userIdentifier) {
    const visits = await countVisits(userIdentifier, prisma);
    console.debug(`visits for ${userIdentifier}: ${JSON.stringify(visits)}`);

    res.setHeader('Content-Type', 'application/json');
    res.status(200);
    res.end(JSON.stringify({ visits }));
  } else {
    res.setHeader('Content-Type', 'application/problem+json');
    res.status(400);
    res.end(JSON.stringify({
      type: 'userIdentifier missing',
      title: 'required parameter "userIdentifier" is missing in the request body.',
      detail: 'please add the field userIdentifier to the json encoded body and try again.'
    }));
  }
});

server.listen(8080, '0.0.0.0', () => {
  console.info('Server running at port 8080');
});

