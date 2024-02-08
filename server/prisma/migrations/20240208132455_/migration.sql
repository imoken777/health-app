/*
  Warnings:

  - You are about to drop the column `name` on the `MealMenu` table. All the data in the column will be lost.
  - You are about to drop the column `ingredients` on the `Recipe` table. All the data in the column will be lost.
  - You are about to drop the column `content` on the `SNSPost` table. All the data in the column will be lost.
  - The primary key for the `WeightHistory` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Like` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `day` on the `Day` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `mealType` to the `MealMenu` table without a default value. This is not possible if the table is not empty.
  - Added the required column `time` to the `MealMenu` table without a default value. This is not possible if the table is not empty.
  - Made the column `dayId` on table `MealMenu` required. This step will fail if there are existing NULL values in that column.
  - Changed the type of `month` on the `Month` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `duration` to the `Movement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `time` to the `Movement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `memo` to the `Recipe` table without a default value. This is not possible if the table is not empty.
  - Added the required column `day` to the `WeightHistory` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "MealType" AS ENUM ('Breakfast', 'Lunch', 'Dinner', 'Snack');

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_SNSPostId_fkey";

-- DropForeignKey
ALTER TABLE "MealMenu" DROP CONSTRAINT "MealMenu_dayId_fkey";

-- AlterTable
ALTER TABLE "Day" DROP COLUMN "day",
ADD COLUMN     "day" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "MealMenu" DROP COLUMN "name",
ADD COLUMN     "mealType" "MealType" NOT NULL,
ADD COLUMN     "time" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "dayId" SET NOT NULL;

-- AlterTable
ALTER TABLE "Month" DROP COLUMN "month",
ADD COLUMN     "month" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Movement" ADD COLUMN     "duration" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "time" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Recipe" DROP COLUMN "ingredients",
ADD COLUMN     "memo" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "SNSPost" DROP COLUMN "content",
ADD COLUMN     "postedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "UserProfile" ALTER COLUMN "birthday" DROP DEFAULT;

-- AlterTable
ALTER TABLE "WeightHistory" DROP CONSTRAINT "WeightHistory_pkey",
ADD COLUMN     "day" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "WeightHistory_pkey" PRIMARY KEY ("day", "userId");

-- DropTable
DROP TABLE "Like";

-- CreateTable
CREATE TABLE "Ingredient" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "recipeId" TEXT NOT NULL,

    CONSTRAINT "Ingredient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reaction" (
    "userId" TEXT NOT NULL,
    "reaction" TEXT NOT NULL,
    "SNSPostId" TEXT,

    CONSTRAINT "Reaction_pkey" PRIMARY KEY ("userId")
);

-- AddForeignKey
ALTER TABLE "Ingredient" ADD CONSTRAINT "Ingredient_recipeId_fkey" FOREIGN KEY ("recipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealMenu" ADD CONSTRAINT "MealMenu_dayId_fkey" FOREIGN KEY ("dayId") REFERENCES "Day"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reaction" ADD CONSTRAINT "Reaction_SNSPostId_fkey" FOREIGN KEY ("SNSPostId") REFERENCES "SNSPost"("id") ON DELETE SET NULL ON UPDATE CASCADE;
