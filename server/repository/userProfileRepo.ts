import type { UserId, UserProfileId } from '$/commonTypesWithClient/ids';
import type { UserProfileModel } from '$/commonTypesWithClient/models';
import { userIdParser, userProfileIdParser } from '$/service/idParsers';
import { prismaClient } from '$/service/prismaClient';
import type { UserProfile as PrismaUserProfile } from '@prisma/client';
import { Gender } from '@prisma/client';
import { z } from 'zod';

// UserProfiles
const toUserProfileModel = (prismaUserProfile: PrismaUserProfile): UserProfileModel => ({
  id: userProfileIdParser.parse(prismaUserProfile.id),
  userName: userIdParser.parse(prismaUserProfile.userName),
  gender: z.nativeEnum(Gender).parse(prismaUserProfile.gender),
  birthday: z.date().parse(prismaUserProfile.birthday),
});

export const userProfileRepo = {
  create: async (userProfile: UserProfileModel) => {
    const prismaUserProfile = await prismaClient.userProfile.create({
      data: {
        id: userProfile.id,
        userName: userProfile.id,
        gender: userProfile.gender,
        birthday: userProfile.birthday,
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
        where: { id: userId },
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
