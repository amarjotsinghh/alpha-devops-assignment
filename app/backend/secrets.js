const { SecretsManagerClient, GetSecretValueCommand } = require("@aws-sdk/client-secrets-manager");

const client = new SecretsManagerClient({
  region: process.env.AWS_REGION
});

async function getDbSecret() {

  const command = new GetSecretValueCommand({
    SecretId: process.env.DB_SECRET_NAME
  });

  const response = await client.send(command);

  if (!response.SecretString) {
    throw new Error("Secret not found");
  }

  return JSON.parse(response.SecretString);

}

module.exports = { getDbSecret };