/*
  Warnings:

  - You are about to drop the column `name` on the `Day` table. All the data in the column will be lost.
  - The primary key for the `Like` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Month` table. All the data in the column will be lost.
  - You are about to drop the column `MealMenuId` on the `SNSPost` table. All the data in the column will be lost.
  - You are about to drop the column `MonthId` on the `SNSPost` table. All the data in the column will be lost.
  - You are about to drop the column `MovementId` on the `SNSPost` table. All the data in the column will be lost.
  - You are about to drop the column `WeightHistoryId` on the `SNSPost` table. All the data in the column will be lost.
  - The primary key for the `UserProfile` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `UserProfile` table. All the data in the column will be lost.
  - The primary key for the `WeightHistory` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `WeightHistory` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[SNSId]` on the table `MealMenu` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[SNSId]` on the table `Month` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[SNSId]` on the table `Movement` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id]` on the table `SNSPost` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userName]` on the table `UserProfile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[SNSId]` on the table `WeightHistory` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `day` to the `Day` table without a default value. This is not possible if the table is not empty.
  - Added the required column `SNSId` to the `MealMenu` table without a default value. This is not possible if the table is not empty.
  - Added the required column `SNSId` to the `Month` table without a default value. This is not possible if the table is not empty.
  - Added the required column `month` to the `Month` table without a default value. This is not possible if the table is not empty.
  - Added the required column `SNSId` to the `Movement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `SNSPost` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userName` to the `UserProfile` table without a default value. This is not possible if the table is not empty.
  - Made the column `birthday` on table `UserProfile` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `SNSId` to the `WeightHistory` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "BookMark" DROP CONSTRAINT "BookMark_userId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_userId_fkey";

-- DropForeignKey
ALTER TABLE "Month" DROP CONSTRAINT "Month_userId_fkey";

-- DropForeignKey
ALTER TABLE "SNSPost" DROP CONSTRAINT "SNSPost_MealMenuId_fkey";

-- DropForeignKey
ALTER TABLE "SNSPost" DROP CONSTRAINT "SNSPost_MonthId_fkey";

-- DropForeignKey
ALTER TABLE "SNSPost" DROP CONSTRAINT "SNSPost_MovementId_fkey";

-- DropForeignKey
ALTER TABLE "SNSPost" DROP CONSTRAINT "SNSPost_WeightHistoryId_fkey";

-- DropForeignKey
ALTER TABLE "WeightHistory" DROP CONSTRAINT "WeightHistory_userId_fkey";

-- DropIndex
DROP INDEX "UserProfile_userId_key";

-- AlterTable
ALTER TABLE "Day" DROP COLUMN "name",
ADD COLUMN     "day" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Like" DROP CONSTRAINT "Like_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "Like_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "MealMenu" ADD COLUMN     "SNSId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Month" DROP COLUMN "name",
ADD COLUMN     "SNSId" TEXT NOT NULL,
ADD COLUMN     "month" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Movement" ADD COLUMN     "SNSId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "SNSPost" DROP COLUMN "MealMenuId",
DROP COLUMN "MonthId",
DROP COLUMN "MovementId",
DROP COLUMN "WeightHistoryId",
ADD COLUMN     "mealMenuId" TEXT,
ADD COLUMN     "monthId" TEXT,
ADD COLUMN     "movementId" TEXT,
ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "UserProfile" DROP CONSTRAINT "UserProfile_pkey",
DROP COLUMN "id",
ADD COLUMN     "userName" TEXT NOT NULL,
ALTER COLUMN "birthday" SET NOT NULL,
ALTER COLUMN "birthday" SET DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "UserProfile_pkey" PRIMARY KEY ("userId");

-- AlterTable
ALTER TABLE "WeightHistory" DROP CONSTRAINT "WeightHistory_pkey",
DROP COLUMN "id",
ADD COLUMN     "SNSId" TEXT NOT NULL,
ADD CONSTRAINT "WeightHistory_pkey" PRIMARY KEY ("userId");

-- CreateIndex
CREATE UNIQUE INDEX "MealMenu_SNSId_key" ON "MealMenu"("SNSId");

-- CreateIndex
CREATE UNIQUE INDEX "Month_SNSId_key" ON "Month"("SNSId");

-- CreateIndex
CREATE UNIQUE INDEX "Movement_SNSId_key" ON "Movement"("SNSId");

-- CreateIndex
CREATE UNIQUE INDEX "SNSPost_id_key" ON "SNSPost"("id");

-- CreateIndex
CREATE UNIQUE INDEX "UserProfile_userName_key" ON "UserProfile"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "WeightHistory_SNSId_key" ON "WeightHistory"("SNSId");

-- AddForeignKey
ALTER TABLE "Month" ADD CONSTRAINT "Month_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserProfile"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Month" ADD CONSTRAINT "Month_SNSId_fkey" FOREIGN KEY ("SNSId") REFERENCES "SNSPost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealMenu" ADD CONSTRAINT "MealMenu_SNSId_fkey" FOREIGN KEY ("SNSId") REFERENCES "SNSPost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Movement" ADD CONSTRAINT "Movement_SNSId_fkey" FOREIGN KEY ("SNSId") REFERENCES "SNSPost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WeightHistory" ADD CONSTRAINT "WeightHistory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserProfile"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WeightHistory" ADD CONSTRAINT "WeightHistory_SNSId_fkey" FOREIGN KEY ("SNSId") REFERENCES "SNSPost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookMark" ADD CONSTRAINT "BookMark_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserProfile"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
