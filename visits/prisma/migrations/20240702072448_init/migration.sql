-- CreateTable
CREATE TABLE "Visit" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userIdentifier" TEXT NOT NULL,
    "loggedAt" DATETIME NOT NULL
);
