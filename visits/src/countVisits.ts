import { PrismaClient } from '@prisma/client';

export async function countVisits(
  userIdentifier: string,
  prisma: PrismaClient
) {
  const prismaTmp = new PrismaClient();
  console.debug(`countVisits called with: ${userIdentifier}, ${prisma}`);
  await prismaTmp.visit.create({
    data: {
      userIdentifier: userIdentifier,
      loggedAt: new Date(),
    } });
  return await prismaTmp.visit.count({
    where: {
      userIdentifier
    }
  });
}
