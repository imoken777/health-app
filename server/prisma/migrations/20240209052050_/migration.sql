/*
  Warnings:

  - You are about to drop the column `height` on the `UserProfile` table. All the data in the column will be lost.
  - You are about to drop the column `targetWeight` on the `UserProfile` table. All the data in the column will be lost.
  - Added the required column `height` to the `WeightHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetWeight` to the `WeightHistory` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "UserProfile" DROP COLUMN "height",
DROP COLUMN "targetWeight";

-- AlterTable
ALTER TABLE "WeightHistory" ADD COLUMN     "height" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "targetWeight" DOUBLE PRECISION NOT NULL;
