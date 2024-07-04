import { PrismaClient } from '@prisma/client';

export async function countVisits(
  userIdentifier: string,
  prisma: PrismaClient
) {
  await prisma.visit.create({
    data: {
      userIdentifier: userIdentifier,
      loggedAt: new Date(),
    } });
  return await prisma.visit.count({
    where: {
      userIdentifier
    }
  });
}
