/*
  Warnings:

  - The primary key for the `UserStatus` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Added the required column `id` to the `UserStatus` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "UserStatus" DROP CONSTRAINT "UserStatus_pkey",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "UserStatus_pkey" PRIMARY KEY ("id");
