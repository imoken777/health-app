-- CreateTable
CREATE TABLE "UserStatus" (
    "userId" TEXT NOT NULL,
    "height" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,
    "age" INTEGER NOT NULL,
    "targetWeight" INTEGER NOT NULL,
    "gender" TEXT NOT NULL,

    CONSTRAINT "UserStatus_pkey" PRIMARY KEY ("userId")
);
