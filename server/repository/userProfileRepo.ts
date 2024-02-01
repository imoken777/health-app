import type { UserId, UserProfileId } from '$/commonTypesWithClient/ids';
import type { UserProfileModel } from '$/commonTypesWithClient/models';
import { userIdParser, userProfileIdParser } from '$/service/idParsers';
import { prismaClient } from '$/service/prismaClient';
import type { UserProfile } from '@prisma/client';
import { z } from 'zod';

// UserProfiles
const toUserProfileModel = (prismaUserProfile: UserProfile): UserProfileModel => ({
  id: userProfileIdParser.parse(prismaUserProfile.id),
  userId: userIdParser.parse(prismaUserProfile.userId),
  height: z.number().parse(prismaUserProfile.height),
  weight: z.number().parse(prismaUserProfile.weight),
  age: z.number().parse(prismaUserProfile.age),
  targetWeight: z.number().parse(prismaUserProfile.targetWeight),
  gender: z.string().parse(prismaUserProfile.gender),
});

export const userProfileRepo = {
  save: async (userProfile: UserProfileModel) => {
    const prismaUserProfile = await prismaClient.userProfile.upsert({
      where: { id: userProfile.id },
      create: {
        id: userProfile.id,
        userId: userProfile.userId,
        height: userProfile.height,
        weight: userProfile.weight,
        age: userProfile.age,
        targetWeight: userProfile.targetWeight,
        gender: userProfile.gender,
      },
      update: {
        height: userProfile.height,
        weight: userProfile.weight,
        age: userProfile.age,
        targetWeight: userProfile.targetWeight,
        gender: userProfile.gender,
      },
    });
    return toUserProfileModel(prismaUserProfile);
  },
  getByUserProfileId: async (userProfileId: UserProfileId): Promise<UserProfileModel | null> => {
    const prismaUserProfile = await prismaClient.userProfile.findUnique({
      where: { id: userProfileId },
    });
    if (prismaUserProfile === null) {
      return null;
    }
    return toUserProfileModel(prismaUserProfile);
  },
  getByUserId: async (userId: UserId): Promise<UserProfileModel | null> => {
    try {
      const prismaUserProfile = await prismaClient.userProfile.findUnique({
        where: { userId },
      });
      if (prismaUserProfile === null) {
        return null;
      }
      return toUserProfileModel(prismaUserProfile);
    } catch (e) {
      console.error(e);
      return null;
    }
  },
};
