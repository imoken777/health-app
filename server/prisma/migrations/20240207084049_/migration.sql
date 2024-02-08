/*
  Warnings:

  - You are about to drop the column `age` on the `UserProfile` table. All the data in the column will be lost.
  - You are about to drop the column `weight` on the `UserProfile` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "UserProfile" DROP COLUMN "age",
DROP COLUMN "weight",
ADD COLUMN     "birthday" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "Month" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Month_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Day" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "monthId" TEXT NOT NULL,

    CONSTRAINT "Day_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Recipe" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "ingredients" TEXT NOT NULL,

    CONSTRAINT "Recipe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MealMenu" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "dayId" TEXT,

    CONSTRAINT "MealMenu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MealMenuRecipe" (
    "id" TEXT NOT NULL,
    "RecipeId" TEXT NOT NULL,
    "MealMenuId" TEXT NOT NULL,

    CONSTRAINT "MealMenuRecipe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Movement" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "dayId" TEXT NOT NULL,

    CONSTRAINT "Movement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WeightHistory" (
    "id" TEXT NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "WeightHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BookMark" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "BookMark_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SNSPost" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "WeightHistoryId" TEXT NOT NULL,
    "MonthId" TEXT NOT NULL,
    "MealMenuId" TEXT NOT NULL,
    "MovementId" TEXT NOT NULL,

    CONSTRAINT "SNSPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Like" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "SNSPostId" TEXT NOT NULL,

    CONSTRAINT "Like_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Month" ADD CONSTRAINT "Month_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Day" ADD CONSTRAINT "Day_monthId_fkey" FOREIGN KEY ("monthId") REFERENCES "Month"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealMenu" ADD CONSTRAINT "MealMenu_dayId_fkey" FOREIGN KEY ("dayId") REFERENCES "Day"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealMenuRecipe" ADD CONSTRAINT "MealMenuRecipe_RecipeId_fkey" FOREIGN KEY ("RecipeId") REFERENCES "Recipe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealMenuRecipe" ADD CONSTRAINT "MealMenuRecipe_MealMenuId_fkey" FOREIGN KEY ("MealMenuId") REFERENCES "MealMenu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Movement" ADD CONSTRAINT "Movement_dayId_fkey" FOREIGN KEY ("dayId") REFERENCES "Day"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WeightHistory" ADD CONSTRAINT "WeightHistory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookMark" ADD CONSTRAINT "BookMark_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SNSPost" ADD CONSTRAINT "SNSPost_WeightHistoryId_fkey" FOREIGN KEY ("WeightHistoryId") REFERENCES "WeightHistory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SNSPost" ADD CONSTRAINT "SNSPost_MonthId_fkey" FOREIGN KEY ("MonthId") REFERENCES "Month"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SNSPost" ADD CONSTRAINT "SNSPost_MealMenuId_fkey" FOREIGN KEY ("MealMenuId") REFERENCES "MealMenu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SNSPost" ADD CONSTRAINT "SNSPost_MovementId_fkey" FOREIGN KEY ("MovementId") REFERENCES "Movement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Like" ADD CONSTRAINT "Like_SNSPostId_fkey" FOREIGN KEY ("SNSPostId") REFERENCES "SNSPost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
